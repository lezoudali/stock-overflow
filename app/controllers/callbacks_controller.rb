class CallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.sign_in_count == 0
        attributes = request.env["omniauth.auth"]
        @user.full_name ||= attributes[:info][:name]
        @user.image ||= attributes[:info][:image]
        @user.save
      end
      
      sign_in_and_redirect @user
    end
end