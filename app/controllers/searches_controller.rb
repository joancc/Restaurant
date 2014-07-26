class SearchesController < ApplicationController
  def index
    Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      puts "*******PARAMS"
      puts "#{search_params[:restaurant_ids]}"
      puts "#{search_params[:category_ids]}"
      flash[:notice] = "Search successful..."
      redirect_to( search_url(@search) )
    else
    end
  end

  def show
    @search = Search.find(params[:id])
    @restaurant_ids = @search.restaurant_ids.scan( /\d+/ ).collect{ |x| x.to_i }
    @category_ids = @search.category_ids.scan( /\d+/ ).collect{|x| x.to_i }
    
    if @restaurant_ids && @category_ids
      @categories = Category.find(@category_ids)
      @restaurants = Restaurant.find(@restaurant_ids)
    else
      @restaurants = Restaurant.find(@restaurant_ids)
    end    

    # Make a new search for user to be able to search from results page
    # This avoids an update command. We always want a new search.
    @search = Search.new
  end

  private

  def search_params
    params.require(:search).permit({:restaurant_ids => []}, {:category_ids => []})
  end
end
