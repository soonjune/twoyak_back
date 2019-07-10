class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)
        if (@user.class == User && @user.persisted?)
          sign_in(@user, store: false)
          @token = JWT.encode(payload(@user), ENV['SECRET_KEY_BASE'], 'HS256')
          render json: { auth_token: @token }
        else
          render json: { errors: "소셜 로그인을 하실 수 없습니다. 같은 이메일로 가입하시지 않으셨나요?" }, status: :unauthorized
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
                :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name, user_info_id: user.user_infos.first.id, login_count: user.sign_in_count},
    }
  end

  def flash
    super
  end
  
end