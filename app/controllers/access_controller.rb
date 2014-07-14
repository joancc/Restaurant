class AccessController < ApplicationController
  def index
  end

  def login
    #Login form
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.where(email: params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      # Uses cookies to mark user as signed in
      # session is just a special cookie?
      session[:user_id] = authorized_user.id
      session[:email] = authorized_user.email
      flash[:notice] = "Logged in successfully."
      redirect_to(controller: 'restaurants', action: 'index')
    else
      flash[:notice] = "Invalidad username or password."
      redirect_to(action: 'login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:email] = nil
    flash[:notice] = "Logged out"
    redirect_to('/access/login')
  end
end