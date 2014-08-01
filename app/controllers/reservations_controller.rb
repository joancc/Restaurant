class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.restaurant_id = params[:restaurant_id]
    @reservation.user_id = current_user ? current_user.id : 0
    @reservation.status = 'Pending'

    @restaurant = Restaurant.find(params[:restaurant_id])
    @user = User.find(@restaurant.user_id)

    if @reservation.save
      flash[:notice] = "Reservation successful."
      ReservationMailer.reservation_notification(@user, @reservation).deliver
      redirect_to(restaurant_path(@restaurant))
    else
      render('restaurants#show')
    end
  end

  private 

  def reservation_params
    params.require(:reservation).permit(:time, :date, :email, :name, :status, :restaurant_id, :user_id)
  end
end