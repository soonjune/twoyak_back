class User::CurrentDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_drug, :search_id, only: [:create, :show, :destroy, :destroy_to_past]
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
    if @current_drug.include?(Drug.find(@search_id))
      render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
    elsif @current_drug << Drug.find(@search_id)
      set_time_memo = CurrentDrug.order("created_at").last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo])
      render json: @current_drug.pluck(:id, :name), status: :created
    else
      render json: @current_drug.pluck(:id, :name), status: :unprocessable_entity
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
    @current_drug.delete(Drug.find(@search_id))
  end

  def destroy_to_past
    selected = CurrentDrug.find_by(current_drug_id: @search_id)
    @current_drug.delete(Drug.find(@search_id))
    @past_drugs =  UserInfo.find(params[:user_info_id]).past_drug
    @past_drugs << Drug.find(@search_id)
    set_time_memo = PastDrug.order("created_at").last
    set_time_memo.update(from: selected.from, to: params[:to] ? params[:to] : Time.zone.now, memo: selected.memo)
    render json: @past_drugs.pluck(:id, :name)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_drug
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_drug = UserInfo.find(params[:user_info_id]).current_drug
      else
        render json: { errors: "잘못된 접근입니다." }, status: :bad_request
        return
      end
    end

    def search_id
      @search_id = params[:search_id]
    end

end
