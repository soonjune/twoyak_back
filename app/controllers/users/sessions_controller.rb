class Users::SessionsController < Devise::SessionsController
    
    require 'jwt'
    
    def create
        user = User.find_for_database_authentication(email: login_params[:email])
        if user.nil?
            render json: { errors: "이메일을 찾을 수 없습니다. 가입 후 이용해 주세요." }, status: :unauthorized
            return
        elsif user.valid_password?(login_params[:password])
            if !user.confirmed?
                User.send_confirmation_instructions({ email: user.email })
                render json: { errors: "이메일 인증을 해주세요. 인증 메일을 보내드렸습니다." }, status: :unauthorized
                return
            end
            sign_in(user, store: false)
            render json: { auth_token: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'], 'HS256') }
            return
		else
			render json: { errors: '유효하지 않은 비밀번호입니다.' }, status: :unauthorized
        end
    end

    # def new
    #     super
    # end

    def update
        if current_user.update_attributes(user_params)
            render :show
        else
            render json: { errors: current_user.errors }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end

    def login_params
        params.permit(:email, :password, :session)
    end

	def payload(user)
		return nil unless user and user.id
		{
                :iss => "twoyak.com",
                :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name },
                :exp => Time.now.to_i + 604800, #1week from now
		}
	end
end
  