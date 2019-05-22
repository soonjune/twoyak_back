class DrugIngrsController < ApplicationController
  before_action :set_drug_ingr, only: [:show, :update, :destroy]
  before_action :authenticate_request!, :is_admin?, only: [:create, :update, :destroy]

  # GET /drug_ingrs
  # def index
  #   # @drug_ingrs = DrugIngr.all
  #   @drug_ingrs = DrugIngr.all
  #   render json: @drug_ingrs
  # end

  # GET /drug_ingrs/1
  def show
    render json: @drug_ingr
  end

  # POST /drug_ingrs
  def create
    @drug_ingr = DrugIngr.new(drug_ingr_params)

    if @drug_ingr.save
      render json: @drug_ingr, status: :created, location: @drug_ingr
    else
      render json: @drug_ingr.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drug_ingrs/1
  def update
    if @drug_ingr.update(drug_ingr_params)
      render json: @drug_ingr
    else
      render json: @drug_ingr.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drug_ingrs/1
  def destroy
    @drug_ingr.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_ingr
      @drug_ingr = DrugIngr.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drug_ingr_params
      params.fetch(:drug_ingr, {})
    end

    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end
    
end
