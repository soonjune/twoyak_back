class DrugAssociationsController < ApplicationController
  before_action :set_drug_association, only: [:show, :update, :destroy]

  # GET /drug_associations
  def index
    @drug_associations = DrugAssociation.all

    render json: @drug_associations
  end

  # GET /drug_associations/1
  def show

    found = DrugAssociation.where(drug_ingr_id: @drug_ingr_id).pluck(:drug_id)
    @result = Drug.select(:id,:name,:item_seq).where(id: found)

    render json: @result
  end

  # # POST /drug_associations
  # def create
  #   @drug_association = DrugAssociation.new(drug_association_params)

  #   if @drug_association.save
  #     render json: @drug_association, status: :created, location: @drug_association
  #   else
  #     render json: @drug_association.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /drug_associations/1
  # def update
  #   if @drug_association.update(drug_association_params)
  #     render json: @drug_association
  #   else
  #     render json: @drug_association.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /drug_associations/1
  # def destroy
  #   @drug_association.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_association
      @drug_ingr_id = params[:drug_ingr_id]
    end

    # Only allow a trusted parameter "white list" through.
    def drug_association_params
      params.fetch(:drug_association, {})
    end
end
