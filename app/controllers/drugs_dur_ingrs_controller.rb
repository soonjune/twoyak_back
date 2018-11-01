class DrugsDurIngrsController < ApplicationController
  before_action :set_drugs_dur_ingr, only: [:show, :update, :destroy]

  # GET /drugs_dur_ingrs
  def index
    @drugs_dur_ingrs = DrugsDurIngr.all

    render json: @drugs_dur_ingrs
  end

  # GET /drugs_dur_ingrs/1
  def show
    render json: @drugs_dur_ingr
  end

  # POST /drugs_dur_ingrs
  def create
    @drugs_dur_ingr = DrugsDurIngr.new(drugs_dur_ingr_params)

    if @drugs_dur_ingr.save
      render json: @drugs_dur_ingr, status: :created, location: @drugs_dur_ingr
    else
      render json: @drugs_dur_ingr.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drugs_dur_ingrs/1
  def update
    if @drugs_dur_ingr.update(drugs_dur_ingr_params)
      render json: @drugs_dur_ingr
    else
      render json: @drugs_dur_ingr.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drugs_dur_ingrs/1
  def destroy
    @drugs_dur_ingr.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drugs_dur_ingr
      @drugs_dur_ingr = DrugsDurIngr.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drugs_dur_ingr_params
      params.require(:drugs_dur_ingr).permit(:drug_id, :dur_ingr_id)
    end
end
