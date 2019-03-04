class User::PastDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_drug, :search_id, only: [:create, :show, :destroy]

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
    if @past_drug << Drug.find(@search_id) 
      set_time_memo = PastDrug.order("created_at").last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo])
      render json: @past_drug.pluck(:id, :name), status: :created
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
    @past_drug.delete(Drug.find(@search_id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_drug
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @past_drug = UserInfo.find(params[:user_info_id]).past_drug
      else
        render json: { errors: "잘못된 접근입니다." }, status: :bad_request
        return
      end
    end

    def search_id
      @search_id = params[:search_id]
    end

end
