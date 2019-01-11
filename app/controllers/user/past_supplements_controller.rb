class User::PastSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_supplement, only: [:show, :destroy]

  # GET /past_supplements
  def index
    @past_supplements = PastSupplement.all

    render json: @past_supplements
  end

  # GET /past_supplements/1
  def show
    render json: @past_supplement
  end

  # POST /past_supplements
  def create
    @past_supplement = Supplement.search(params[:sup_name], fields: [name: :exact])

    if @past_supplement.save
      render json: @past_supplement, status: :created, location: @past_supplement
    else
      render json: @past_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /past_supplements/1
  # def update
  #   if @past_supplement.update(past_supplement_params)
  #     render json: @past_supplement
  #   else
  #     render json: @past_supplement.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /past_supplements/1
  def destroy
    @past_supplement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_supplement
      @past_supplement = PastSupplement.find(params[:id])
    end

end
