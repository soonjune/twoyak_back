class DiseasesController < ApplicationController
  before_action :set_disease, only: [:show, :update, :destroy]

  # GET /diseases
  def index
    @diseases = Disease.all

    render json: @diseases
  end

  # GET /diseases/1
  def show
    render json: @disease
  end

  # POST /diseases
  def create
    @disease = Disease.new(disease_params)

    if @disease.save
      render json: @disease, status: :created, location: @disease
    else
      render json: @disease.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diseases/1
  def update
    if @disease.update(disease_params)
      render json: @disease
    else
      render json: @disease.errors, status: :unprocessable_entity
    end
  end

  # DELETE /diseases/1
  def destroy
    @disease.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disease
      @disease = Disease.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def disease_params
      params.require(:disease).permit(:name)
    end
end
