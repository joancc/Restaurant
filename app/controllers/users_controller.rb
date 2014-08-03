class UsersController < ApplicationController
  def dashboard
    if current_user.owner?
      @restaurants = Restaurant.where(user_id = current_user.id)
      @todays_reservations = Reservation.where(date: Date.today)
    else
      @restaurants = current_user.starred_restaurants
    end
  end
end
