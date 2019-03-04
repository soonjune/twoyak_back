class User::PastSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_supplement, :search_id, only: [:create, :show, :destroy]

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
    if @past_supplement << Supplement.find(@search_id)
      set_time_memo = PastSupplement.order("created_at").last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo])
      render json: @past_supplement.pluck(:id, :name), status: :created
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
    @past_supplement.delete(Supplement.find(@search_id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_supplement
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @past_supplement = UserInfo.find(params[:user_info_id]).past_sup
      end
    else
      render json: { errors: "잘못된 접근입니다." }, status: :bad_request
      return
    end

    def search_id
      @search_id = params[:search_id]
    end
end
