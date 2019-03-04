class User::CurrentSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_supplement, :search_id, only: [:create, :show, :destroy, :destroy_to_past]

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
    if @current_supplement.include?(Supplement.find(@search_id))
      render json: { errors: "이미 복용 중인 건강식품입니다." }, status: :unprocessable_entity
    elsif @current_supplement << Supplement.find(@search_id)
      set_time_memo = CurrentSupplement.order("created_at").last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo])
      render json: @current_supplement.pluck(:id, :name), status: :created
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
    @current_supplement.delete(Supplement.find(@search_id))
  end

  def destroy_to_past
    selected = CurrentSupplement.find_by(current_supplement_id: @search_id)
    @current_supplement.delete(Supplement.find(@search_id))
    @past_supplements =  UserInfo.find(params[:user_info_id]).past_sup
    @past_supplements << Supplement.find(@search_id)
    set_time_memo = PastSupplement.order("created_at").last
    set_time_memo.update(from: selected.from, to: params[:to] ? params[:to] : Time.zone.now, memo: selected.memo)
    render json: @past_supplements.pluck(:id, :name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_supplement
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_supplement = UserInfo.find(params[:user_info_id]).current_sup
      else
        render json: { errors: "잘못된 접근입니다." }, status: :bad_request
        return
      end
    end

    def search_id
      @search_id = params[:search_id]
    end

end
