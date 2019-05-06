class SuggestionsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_suggestion, only: [:show, :update, :destroy]
  before_action :is_admin?, only: [:index, :destroy]

  # GET /suggestions
  def index
    @suggestions = Suggestion.all

    render json: @suggestions
  end

  # GET /suggestions/1
  def show
    render json: @suggestion
  end

  # POST /suggestions
  def create
    @suggestion = Suggestion.new(suggestion_params)

    if @suggestion.save
      render json: @suggestion, status: :created, location: @suggestion
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /suggestions/1
  def update
    if @suggestion.update(suggestion_params)
      render json: @suggestion
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /suggestions/1
  def destroy
    @suggestion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      unless current_user.has_role? "admin"
        if current_user.suggestion_ids.include? params[:id]
          @suggestion = Suggestion.find(params[:id])
        end
      else
        @suggestion = Suggestion.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def suggestion_params
      params.require(:suggestion).permit(:user_id, :title, :body, :contact)
    end

    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end
end
