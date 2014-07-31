class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    # raise request.env["omniauth.auth"].to_yaml
    # Method from_omniautg defined in user.rb
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
        flash.notice = "Signed in successfully!"
        # devide provided method
        sign_in_and_redirect user 
    else
        # Start session with devise to persist and display errors to user
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
    end
  end
end
