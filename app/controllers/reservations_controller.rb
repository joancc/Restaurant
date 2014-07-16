class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.restaurant_id = params[:restaurant_id]
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user = User.find(@restaurant.user_id)

    if @reservation.save
      flash[:notice] = "Reservation successful."
      render('/restaurants/show')
    else
      render('restaurants#show')
    end
  end

  private 

  def reservation_params
    params.require(:reservation).permit(:time, :email, :restaurant_id)
  end
end