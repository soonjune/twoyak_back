class Users::PasswordsController < Devise::PasswordsController
    def create
        self.resource = resource_class.send_reset_password_instructions(user_params)
        if successfully_sent?(resource)
        render json: {status: 'ok'}, status: :ok
        else
        render json: {error: ['Error occurred']}, status: :internal_server_error
        end
    end        

    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end

end
