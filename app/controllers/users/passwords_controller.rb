class Users::PasswordsController < Devise::PasswordsController
    def create
        self.resource = resource_class.send_reset_password_instructions(params)
    
        if successfully_sent?(resource)
          render json: {status: 'ok'}, status: :ok
        else
          render json: {error: ['Error occurred']}, status: :internal_server_error
        end
    end
    
      # GET /user/password/edit?reset_password_token=blablabla
      def edit
        self.resource = resource_class.new
        set_minimum_password_length
        resource.reset_password_token = params[:reset_password_token]
        uri = URI("http://localhost:3000/reset-password")
        uri.query = URI.encode_www_form(:token => params[:reset_password_token])
        redirect_to uri.to_s
      end
    
      # PUT /user/password
      def update
        self.resource = resource_class.reset_password_by_token(resource_params)
        yield resource if block_given?
    
        if resource.errors.empty?
          resource.unlock_access! if unlockable?(resource)
          if Devise.sign_in_after_reset_password
            flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
            set_flash_message!(:notice, flash_message)
            resource.after_database_authentication
            sign_in(resource_name, resource)
          else
            set_flash_message!(:notice, :updated_not_active)
          end
          render json: {
            success: true,
            data: resource,
            message: I18n.t("devise_token_auth.passwords.successfully_updated")
          }
        else
          set_minimum_password_length
          respond_with resource
        end
    end
    
    
      protected
        def after_resetting_password_path_for(resource)
          Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
        end
    
        # Check if a reset_password_token is provided in the request
        def assert_reset_token_passed
          if params[:reset_password_token].blank?
            set_flash_message(:alert, :no_token)
            redirect_to new_session_path(resource_name)
          end
        end
    
        # Check if proper Lockable module methods are present & unlock strategy
        # allows to unlock resource on password reset
        def unlockable?(resource)
          resource.respond_to?(:unlock_access!) &&
            resource.respond_to?(:unlock_strategy_enabled?) &&
            resource.unlock_strategy_enabled?(:email)
        end
end
