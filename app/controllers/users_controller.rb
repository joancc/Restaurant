class UsersController < ApplicationController
  def dashboard
    if current_user.owner?
      @restaurants = current_user.restaurants
    else
      @restaurants = current_user.starred_restaurants
    end
  end
end
