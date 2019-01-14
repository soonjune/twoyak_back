class User::CurrentDiseasesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_disease, :search_term, only: [:create, :show, :destroy, :destroy_to_past]

  # GET /current_diseases
  def index
    @current_diseases = CurrentDisease.all

    render json: @current_diseases
  end

  # GET /current_diseases/1
  def show
    render json: @current_disease
  end

  # POST /current_diseases
  def create
    if @current_disease << Disease.find_by_disease_name(@search_term)
      render json: @current_disease, status: :created
    else
      render json: @current_disease.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /current_diseases/1
  # def update
  #   if @current_disease.update(current_disease_params)
  #     render json: @current_disease
  #   else
  #     render json: @current_disease.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /current_diseases/1
  def destroy
    @current_disease.delete(Disease.find_by_disease_name(@search_term))
  end

  def destroy_to_past
    @current_disease.delete(Disease.find_by_disease_name(@search_term))
    @past_diseases =  UserInfo.find(params[:user_info_id]).past_disease
    @past_diseases << Disease.find_by_disease_name(@search_term)
    render json: @past_diseases
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_disease
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_disease = UserInfo.find(params[:user_info_id]).current_disease
      end
    end

    def search_term
      @search_term = params[:search_term]
    end
    
end
