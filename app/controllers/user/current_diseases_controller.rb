class User::CurrentDiseasesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_disease, only: [:show, :destroy]

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
    @current_disease << CurrentDisease.search(params[:disease_name], fields: [disease_name: :exact]) 

    if @current_disease.save
      render json: @current_disease, status: :created, location: @current_disease
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
    @current_disease.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_disease
      @current_disease = UserInfo.find(params[:id]).current_disease
    end
end
