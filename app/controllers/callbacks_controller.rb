class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.sign_in_count == 0
        attributes = request.env["omniauth.auth"]
        @user.first_name ||= attributes[:info][:first_name]
        @user.last_name ||= attributes[:info][:last_name]
        @user.image ||= attributes[:info][:image]
        @user.save
      end

      sign_in_and_redirect @user
    end
end