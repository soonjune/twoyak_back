class ChangeTokenController < ApplicationController
      attr_reader :current_user

    def change
        if user_id_in_token?
          @current_user = User.find(auth_token[:user_id])
          render json: { auth_token: JWT.encode(payload(@current_user), ENV['SECRET_KEY_BASE'], 'HS256') }
        end
        rescue JWT::VerificationError, JWT::DecodeError
          render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end

    private
    
    def http_token
        @http_token ||= if request.headers['Authorization'].present?
          request.headers['Authorization'].split(' ').last
        end
    end
  
    def auth_token
      @auth_token ||= HashWithIndifferentAccess.new(JWTWrapper.decode(http_token))
    end
  
    def user_id_in_token?
      !(http_token && auth_token && auth_token).nil? ? http_token && auth_token && auth_token[:user_id].to_i : false
    end

    def payload(user)
        return nil unless user and user.id
        {
                    :iss => "twoyak.com",
                    :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name, user_info_id: user.user_infos.first.id },
        }
        end
end
