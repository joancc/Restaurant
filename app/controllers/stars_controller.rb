class StarsController < ApplicationController
  def create
    @star = Star.new
    # puts "STAR PARAMS: #{params[:restaurant_id]}"
    # puts "STAR PARAMS: #{params[:star][:user_id]}"
    @star.restaurant_id = params[:star][:restaurant_id]
    @star.user_id = params[:star][:user_id]
    @restaurant = Restaurant.find(params[:restaurant_id])

    if @star.save
      flash[:notice] = "Starred successfully."
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = "Could not star. Please try again later."
    end
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @star =Star.where("restaurant_id = ? AND user_id = ?", params[:star][:restaurant_id], params[:star][:user_id]).first
    @star.destroy
    redirect_to restaurant_path(@restaurant)
  end

private

  def star_params
    params.require(@star).permit(:restaurant_id, :user_id)
  end
end