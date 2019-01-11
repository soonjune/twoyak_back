class User::FamilyMedHistoriesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_family_med_history, only: [:show, :destroy]

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
    @family_med_history << Disease.search(search_term, fields: [disease_name: :exact]) 

    if @family_med_history.save
      render json: @family_med_history, status: :created, location: @family_med_history
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
    @family_med_history.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family_med_history
      @family_med_history = UserInfo.find(params[:id]).med_his
    end

end
