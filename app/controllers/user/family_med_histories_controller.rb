class User::FamilyMedHistoriesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_family_med_history, :search_id, only: [:create, :show, :destroy]

  # GET /family_med_histories
  def index
    @family_med_histories = FamilyMedHistory.all

    render json: @family_med_histories
  end

  # GET /family_med_histories/1
  def show
    render json: @family_med_history
  end

  # POST /family_med_histories
  def create
    if @family_med_history << Disease.find(@search_id)
      render json: @family_med_history, status: :created
    else
      render json: @family_med_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /family_med_histories/1
  # def update
  #   if @family_med_history.update(family_med_history_params)
  #     render json: @family_med_history
  #   else
  #     render json: @family_med_history.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /family_med_histories/1
  def destroy
    @family_med_history.delete(Disease.find(@search_id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family_med_history
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @family_med_history = UserInfo.find(params[:user_info_id]).med_his
      end
    end

    def search_id
      @search_id = params[:search_id]
    end

end
