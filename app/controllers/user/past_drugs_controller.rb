class User::PastDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_drug, :search_term, only: [:create, :show, :destroy]

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
    if @past_drug << Drug.search(@search_term, fields: [name: :exact]) 

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
    @past_drug.delete(Drug.search(@search_term, fields: [name: :exact]))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_drug
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @past_drug = UserInfo.find(params[:user_info_id]).past_drug
      end
    end

    def search_term
      @search_term = params[:search_term]
    end

end
