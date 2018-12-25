class SessionsController < Devise::SessionsController

    require 'jwt'
    
    def create
        user = User.new(user_params)
        user.save
        info = UserInfo.new(info_params)
        info.user_id = user.id

        if info.save
            render json: { stauts: 'User created successfully', payload: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'] )}, status: :created
        else
            render json: { errors1: user.errors.full_messages, errors2: info.errors.full_messages }, status: :bad_request
        end
    end

    def new
        user = User.find_for_database_authentication(email: params[:email])
		if user.valid_password?(params[:password])
				render json: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'])
		else
				render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
        end
    end

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
    def info_params
        params.permit(:user_name, :profile_image, :birth_date, :drink, :smoke, :caffeine)
    end

	def payload(user)
		return nil unless user and user.id
		{
				user: {id: user.id, email: user.email, user_name: user.user_infos.first }
		}
	end
end
  