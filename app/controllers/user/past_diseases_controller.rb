class User::PastDiseasesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_disease, only: [:show, :destroy]

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
    @past_disease << Disease.search(params[:disease_name], fields: [disease_name: :exact])

    if @past_disease.save
      render json: @past_disease, status: :created, location: @past_disease
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
    @past_disease.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_disease
      @past_disease = UserInfo.find(params[:id]).past_disease
    end
end
