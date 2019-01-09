# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if User.new(user_params).valid? && UserInfo.new(info_params).valid?
      user = User.new(user_params)
      user.save
      info = UserInfo.new(info_params)
      info.user_id = user.id
    else
      render json: { errors: "필수 정보를 모두 채워주세요" }, status: :bad_request
      return
    end

    if info.save
        render json: { stauts: 'User created successfully', auth_token: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'], 'HS256') }, status: :created
    else
        render json: { errors1: user.errors.full_messages, errors2: info.errors.full_messages }, status: :bad_request
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
  def info_params
      params.permit(:user_name, :profile_image, :birth_date, :drink, :smoke, :caffeine)
  end

  def payload(user)
  return nil unless user and user.id
  {
              :iss => "twoyak.com",
              :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name },
              :exp => Time.now.to_i + 604800, #1week from now
  }
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
