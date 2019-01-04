class SupplementsController < ApplicationController
  before_action :set_supplement, only: [:update, :destroy]
  before_action :set_search, only: [:show]

  # GET /supplements
  def index
    @supplements = Supplement.all

    render json: @supplements
  end

  # GET /supplements/1
  def show
    render json: @supplement
  end

  # POST /supplements
  def create
    @supplement = Supplement.new(supplement_params)

    if @supplement.save
      render json: @supplement, status: :created, location: @supplement
    else
      render json: @supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /supplements/1
  def update
    if @supplement.update(supplement_params)
      render json: @supplement
    else
      render json: @supplement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /supplements/1
  def destroy
    @supplement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplement
      @supplement = Supplement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supplement_params
      params.require(:supplement).permit(:production_code, :product_name, :enterprise_name, :benefits, :suggested_use, :ingredients, :storage, :shelf_life, :description, :warnings, :standard, :approval_date)
    end

    def set_search
      @supplement = Supplement.search(params[:search_term], fields: [name: :exact])
    end
end
