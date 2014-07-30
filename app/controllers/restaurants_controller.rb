class RestaurantsController < ApplicationController
  before_action :set_params, only: [:index]

  def index
    @restaurants = Restaurant.all
    @locations = @restaurants.map{|rest|
      rest.location
    }
    @categories_by_restaurant = @restaurants.map{|rest|
      rest.categories
    }

    @marker_icons = @categories_by_restaurant.map{|cat|
      cat[0].name+".png"
    }

    @restaurants_urls = @restaurants.map{|rest|
      restaurant_url(rest)
    }

    @categories = Category.all
    
  end

  def jsonView
    @restaurants = Restaurant.all
    render json: @restaurants.to_json(only: [:address], include: :user)
  end

  def show
    
    @restaurant = Restaurant.find(params[:id])
    @user = User.find(@restaurant.user_id)
    @reservation = Reservation.new(restaurant_id: @restaurant[:id])
    @owned_reservations = Reservation.where(restaurant_id: @restaurant[:id])

    if current_user && @restaurant.starred_by.where(id: current_user[:id]).empty?
      @star = Star.new
      @user_id = current_user.id
    else
      @star = Star.where("restaurant_id = ? AND user_id = ?", @restaurant.id, current_user[:id]).first
      @user_id = current_user.id
    end
  end

  def new
    
    @restaurant = Restaurant.new
    @restaurant.categories.build
    @category_names = Category.all.map{|category| category.name}
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.category_ids = params[:restaurant][:category_ids]
    
    if current_user.owner?
      @restaurant.user = current_user
      if @restaurant.save
        @location = Location.new
        @location[:address] = @restaurant.address
        @location[:restaurant_id] = @restaurant.id
        if@location.save
          flash[:notice] = "Restaurant created successfully."
          redirect_to(action: 'index')
        else
          flash[:error] = @location.errors.full_messages[0]
          render('new')  
        end
      else
        flash[:error] = @restaurant.errors.full_messages[0]
        render('new')
      end
    else
      flash[:error] = "Please login as an owner to create a new entry."
      render('new')
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      @restaurant.location.update_attributes(address: @restaurant.address)
      flash[:notice] = "Restaurant updated successfully."
      redirect_to(action: 'show')
    else
      render('form')
    end
  end

  def destroy
    restaurant = Restaurant.find(params[:id])
    restaurant.destroy
    redirect_to(action: 'index')

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  private

  def set_params
    @restaurants = Restaurant.all
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :description, :phone, :image, :menu, :category_ids)
  end
end
