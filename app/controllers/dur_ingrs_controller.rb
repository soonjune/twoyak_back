class DurIngrsController < ApplicationController
  before_action :set_dur_ingr, only: [:update, :destroy]
  before_action :set_search, only: [:show]

  # GET /dur_ingrs
  def index
    @dur_ingrs = DurIngr.all

    render json: @dur_ingrs
  end

  # GET /dur_ingrs/1
  def show
    render json: @dur_ingr
  end

  # POST /dur_ingrs
  def create
    @dur_ingr = DurIngr.new(dur_ingr_params)

    if @dur_ingr.save
      render json: @dur_ingr, status: :created, location: @dur_ingr
    else
      render json: @dur_ingr.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dur_ingrs/1
  def update
    if @dur_ingr.update(dur_ingr_params)
      render json: @dur_ingr
    else
      render json: @dur_ingr.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dur_ingrs/1
  def destroy
    @dur_ingr.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dur_ingr
      @dur_ingr = DurIngr.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dur_ingr_params
      params.require(:dur_ingr).permit(:dur_code, :ingr_eng_name, :ingr_kor_name, :related_ingr_code, :related_ingr_kor_name, :related_ingr_eng_name)
    end

    def set_search
      @dur_ingr = DurIngr.search(search_term)
    end
end
