class UsersController < ApplicationController
    before_action :authenticate_user!

    def create
        user = User.new(user_params)
      
        if user.save
            render json: {status: 'User created successfully'}, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :bad_request
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
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
  