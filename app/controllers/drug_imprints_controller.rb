class DrugImprintsController < ApplicationController
  before_action :set_drug_imprint, only: [:show, :update, :destroy]

  # GET /drug_imprints
  def index
    @drug_imprints = DrugImprint.all

    render json: @drug_imprints
  end

  # GET /drug_imprints/1
  def show
    render json: @drug_imprint
  end

  # POST /drug_imprints
  def create
    @drug_imprint = DrugImprint.new(drug_imprint_params)

    if @drug_imprint.save
      render json: @drug_imprint, status: :created, location: @drug_imprint
    else
      render json: @drug_imprint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drug_imprints/1
  def update
    if @drug_imprint.update(drug_imprint_params)
      render json: @drug_imprint
    else
      render json: @drug_imprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drug_imprints/1
  def destroy
    @drug_imprint.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_imprint
      @drug_imprint = DrugImprint.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drug_imprint_params
      params.require(:drug_imprint).permit(:drug_id, :item_name, :description, :dosage_form, :drug_image, :print_front, :print_back, :drug_shape, :color_front, :color_back, :line_front, :line_back, :length_long, :length_short, :thickness, :mark_content_front, :mark_content_back, :mark_img_front, :mark_img_back, :mark_code_front, :mark_code_back)
    end
end
