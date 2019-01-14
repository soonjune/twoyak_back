class User::CurrentDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_drug, :search_term, only: [:create, :show, :destroy, :destroy_to_past]
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
    if @current_drug << Drug.search(@search_term, fields: [name: :exact]) 
      render json: @current_drug, status: :created
    else
      render json: @current_drug, status: :unprocessable_entity
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
    @current_drug.delete(Drug.search(@search_term, fields: [name: :exact]))
  end

  def destroy_to_past
    @current_drug.delete(Drug.search(@search_term, fields: [name: :exact]))
    @past_drugs =  UserInfo.find(params[:user_info_id]).past_drug
    @past_drugs << Drug.search(@search_term, fields: [name: :exact])
    render json: @past_drugs
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_drug
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_drug = UserInfo.find(params[:user_info_id]).current_drug
      end
    end

    def search_term
      @search_term = params[:search_term]
    end

end
