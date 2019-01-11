class User::PastDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_drug, only: [:show, :destroy]

  # GET /past_drugs
  def index
    @past_drugs = PastDrug.all

    render json: @past_drugs
  end

  # GET /past_drugs/1
  def show
    render json: @past_drug
  end

  # POST /past_drugs
  def create
    @past_drug = Drug.search(params[:drug_name], fields: [name: :exact]) 

    if @past_drug.save
      render json: @past_drug, status: :created, location: @past_drug
    else
      render json: @past_drug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /past_drugs/1
  # def update
  #   if @past_drug.update(past_drug_params)
  #     render json: @past_drug
  #   else
  #     render json: @past_drug.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /past_drugs/1
  def destroy
    @past_drug.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_drug
      @past_drug = UserInfo.find(params[:id]).past_drug
    end

end
