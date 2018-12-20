class SessionsController < Devise::SessionsController

    def create
        user = User.new(user_params)
        user.save
        info = UserInfo.new(info_params)
        info.user_id = user.id

        if info.save
            render json: {status: 'User created successfully'}, status: :created
        else
            render json: { errors1: user.errors.full_messages, errors2: info.errors.full_messages }, status: :bad_request
        end
    end

    def show
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
end
  