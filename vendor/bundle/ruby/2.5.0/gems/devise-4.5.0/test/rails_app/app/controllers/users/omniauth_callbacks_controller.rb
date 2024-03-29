class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)
        if (@user.class == User && @user.persisted?)
          sign_in(@user, store: false)
          render json: { auth_token: JWT.encode(payload(@user), ENV['SECRET_KEY_BASE'], 'HS256') }
          return
        elsif @user == "already exists"
          render json: { errors: '이메일로 직접 가입하셨거나 다른 소셜 계정으로 가입한 이메일입니다.' }, status: :unauthorized
        else
          session["devise.#{provider}_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
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
                :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name, user_info_id: user.user_infos.first.id },
    }
    end
  
end