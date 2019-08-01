class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:infos_for_mobile]

    def finish_signup
        if request.patch? && params[:user] #&& params[:user][:email]
            if current_user.update(user_params)
            current_user.skip_reconfirmation!
            sign_in(current_user, :bypass => true)
            redirect_to current_user, notice: 'Your profile was successfully updated.'
            else
            @show_errors = true
            end
        end
    end

    def infos_for_mobile
        user_id = params[:id]
        infos = User.find(user_id).user_info_ids.first

        render json: { user_info_id: infos }
    end

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

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
  