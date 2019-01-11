class User::CurrentDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_drug, only: [:show, :destroy]

  # GET /current_drugs
  def index
    @current_drugs = CurrentDrug.all

    render json: @current_drugs
  end

  # GET /current_drugs/1
  def show
    render json: @current_drug
  end

  # POST /current_drugs
  def create
    @current_drug = Drug.search(params[:drug_name], fields: [name: :exact]) 

    if @current_drug.save
      render json: @current_drug, status: :created, location: @current_drug
    else
      render json: @current_drug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current_drugs/1
  # def update
  #   if @current_drug.update(current_drug_params)
  #     render json: @current_drug
  #   else
  #     render json: @current_drug.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /current_drugs/1
  def destroy
    @current_drug.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_drug
      @current_drug = UserInfo.find(params[:id]).current_drug
    end

end
