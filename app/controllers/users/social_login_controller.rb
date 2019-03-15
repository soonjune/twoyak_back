class Users::SocialLoginController < ApplicationController

    def sign_in

        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth)

        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user = current_user ? current_user : identity.user
        if !user.nil?
            render json: { stauts: 'Logged in successfully', auth_token: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'], 'HS256') }, status: :created
            return
        end

        user = User.where(email: auth[:email]).first
        if user.nil?
          
            # Create the user if it's a new registration
          user = User.new(
            email: auth[:email],
            password: Devise.friendly_token[0,20]
          )
          user.skip_confirmation!
          user.save!
          info = UserInfo.new(info_params)
          info.user_id = user.id
          info.save!

          if identity.user != user
            identity.user = user
            identity.save!
          end

          render json: { stauts: 'User created successfully', auth_token: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'], 'HS256') }, status: :created

        else
            render json: { errors: '이메일로 직접 가입하셨거나 다른 소셜 계정으로 가입한 이메일입니다.' }, status: :unauthorized
        end


    end

    protected

    def auth
        params.permit(:uid, :provider, :email, :user_name)
    end

    def info_params
        params.permit(:user_name, :profile_image, :birth_date, :drink, :smoke, :caffeine)
    end
  
    def payload(user)
        return nil unless user and user.id
        {
                    :iss => "twoyak.com",
                    :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name, user_info_id: user.user_infos.first.id },
        }
        end

end
