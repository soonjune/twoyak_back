class User::CurrentSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_supplement, only: [:show, :destroy]

  # GET /current_supplements
  def index
    @current_supplements = CurrentSupplement.all

    render json: @current_supplements
  end

  # GET /current_supplements/1
  def show
    render json: @current_supplement
  end

  # POST /current_supplements
  def create
    @current_supplement = Supplement.search(params[:sup_name], fields: [name: :exact])

    if @current_supplement.save
      render json: @current_supplement, status: :created, location: @current_supplement
    else
      render json: @current_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current_supplements/1
  # def update
  #   if @current_supplement.update(current_supplement_params)
  #     render json: @current_supplement
  #   else
  #     render json: @current_supplement.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /current_supplements/1
  def destroy
    @current_supplement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_supplement
      @current_supplement = UserInfo.find(params[:id]).current_supplement
    end

end
