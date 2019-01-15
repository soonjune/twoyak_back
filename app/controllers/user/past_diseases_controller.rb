class User::PastDiseasesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_disease, :search_id, only: [:create, :show, :destroy]

  # GET /past_diseases
  def index
    @past_diseases = PastDisease.all

    render json: @past_diseases
  end

  # GET /past_diseases/1
  def show
    render json: @past_disease
  end

  # POST /past_diseases
  def create
    if @past_disease << Disease.find(@search_id)
      render json: @past_disease, status: :created
    else
      render json: @past_disease.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /past_diseases/1
  # def update
  #   if @past_disease.update(past_disease_params)
  #     render json: @past_disease
  #   else
  #     render json: @past_disease.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /past_diseases/1
  def destroy
    @past_disease.delete(Disease.find(@search_id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_disease
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @past_disease = UserInfo.find(params[:user_info_id]).past_disease
      end
    end

    def search_id
      @search_id = params[:search_id]
    end
end
