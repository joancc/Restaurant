class UsersController < ApplicationController
  def dashboard
    @restaurants = Restaurant.where(user_id: current_user.id)
  end
end
