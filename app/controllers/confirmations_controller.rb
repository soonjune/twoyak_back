# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    # def new
    #   super
    # end
  
    # POST /resource/confirmation
    # def create
    #   super
    # end
  
    # GET /resource/confirmation?confirmation_token=abcdef
    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?
  
      if resource.errors.empty?
        redirect_to root_path
      else
        respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
      end
    end
  
    # protected
  
    # The path used after resending confirmation instructions.
    # def after_resending_confirmation_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  
    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      root_path
    end
  end