class Users::SocialLoginController < ApplicationController

    def sign_in
        require 'payload'

        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth)

        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user = current_user ? current_user : identity.user
        if !user.nil?
            result = Payload.jwt_encoded(user)
            result[:status] = 'Logged in successfully'
            render json: result, status: :created
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
          info = SubUser.new(info_params)
          info.user_id = user.id
          info.save!

          if identity.user != user
            identity.user = user
            identity.save!
          end

          result = Payload.jwt_encoded(user)
          result[:status] = 'User created successfully'
          render json: result, status: :created

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
  

end
