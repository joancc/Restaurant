class UsersController < ApplicationController
  def dashboard
    @restaurants = Restaurant.all
    # where(user_id: current_user.id)
  end
end
