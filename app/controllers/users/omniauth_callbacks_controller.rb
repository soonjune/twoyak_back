class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    require 'payload'
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)
        if (@user.class == User && @user.persisted?)
          sign_in(@user, store: false)
          uri = URI("http://localhost:3000/login")
          redirect_to uri.to_s, Payload.jwt_encoded(@user)
        else
          uri = URI("http://localhost:3000/login-error")
          redirect_to uri.to_s
        end
      end
    }
  end

  [:facebook, :google_oauth2, :naver].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    return
  end

  def payload(user)
    return nil unless user and user.id
    {
                :iss => "twoyak.com",
                :user => {id: user.id, email: user.email, sub_users: user.sub_users.select(:id, :user_name).as_json },
    }
  end

  def flash
    super
  end
  
end