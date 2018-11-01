class SupplementIngrsSupplementsController < ApplicationController
  before_action :set_supplement_ingrs_supplement, only: [:show, :update, :destroy]

  # GET /supplement_ingrs_supplements
  def index
    @supplement_ingrs_supplements = SupplementIngrsSupplement.all

    render json: @supplement_ingrs_supplements
  end

  # GET /supplement_ingrs_supplements/1
  def show
    render json: @supplement_ingrs_supplement
  end

  # POST /supplement_ingrs_supplements
  def create
    @supplement_ingrs_supplement = SupplementIngrsSupplement.new(supplement_ingrs_supplement_params)

    if @supplement_ingrs_supplement.save
      render json: @supplement_ingrs_supplement, status: :created, location: @supplement_ingrs_supplement
    else
      render json: @supplement_ingrs_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /supplement_ingrs_supplements/1
  def update
    if @supplement_ingrs_supplement.update(supplement_ingrs_supplement_params)
      render json: @supplement_ingrs_supplement
    else
      render json: @supplement_ingrs_supplement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /supplement_ingrs_supplements/1
  def destroy
    @supplement_ingrs_supplement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplement_ingrs_supplement
      @supplement_ingrs_supplement = SupplementIngrsSupplement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supplement_ingrs_supplement_params
      params.require(:supplement_ingrs_supplement).permit(:supplement_id, :supplement_ingr_id)
    end
end
