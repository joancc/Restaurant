class StarsController < ApplicationController
  def create
    @star = Star.new
    @star.restaurant_id = params[:star][:restaurant_id]
    @star.user_id = params[:star][:user_id]
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user_id = current_user ? current_user.id : 0
    puts "************USER_ID: #{@user_id}"
    if @star.save
      flash[:notice] = "Starred successfully."
      respond_to do |format|
        format.js {  }
        format.html { redirect_to restaurant_path(@restaurant) }
      end
    else
      flash[:alert] = "Could not star. Please try again later."
    end
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @star = Star.where("restaurant_id = ? AND user_id = ?", params[:star][:restaurant_id], params[:star][:user_id]).first
    @star.destroy
    @star = Star.new 
    @user_id = current_user ? current_user.id : 0
    respond_to do |format|
      format.js {  }
      format.html { redirect_to restaurant_path(@restaurant) }
    end
  end

private

  def star_params
    params.require(@star).permit(:restaurant_id, :user_id)
  end
end