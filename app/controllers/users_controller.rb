class UsersController < ApplicationController
  def dashboard
    @restaurants = current_user.restaurants
  end
end
