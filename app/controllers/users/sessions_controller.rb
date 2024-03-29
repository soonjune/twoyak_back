class Users::SessionsController < Devise::SessionsController
        
    def create
        require 'payload'
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
            if !user.confirmed?
                user.skip_confirmation!
            end
            sign_in(user, store: false)
            render json: Payload.jwt_encoded(user)
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


end
  