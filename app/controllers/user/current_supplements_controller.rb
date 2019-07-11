class User::CurrentSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_supplement, :search_id, only: [:create, :show, :update, :destroy, :destroy_to_past]
  before_action :update_current_supplement, only: [:update]
  before_action :id_to_modify, only: [:update, :destroy, :destroy_to_past]

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
      set_time_memo = CurrentSupplement.where(sub_user_id: params[:sub_user_id], current_supplement_id: @search_id).last
      set_time_memo.update(from: params[:from] ? params[:from] : Time.zone.now, to: params[:to], memo: params[:memo])
      render json: @current_supplement.pluck(:id, :name), status: :created
    else
      render json: @current_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current_supplements/1
  def update
    if @current_supplement.update(@current_supplement_params)
      render json: @current_supplement
    else
      render json: @current_supplement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /current_supplements/1
  def destroy
    CurrentSupplement.find(@id_to_modify).delete
  end

  def destroy_to_past
    selected = CurrentSupplement.find(@id_to_modify)
    CurrentSupplement.find(@id_to_modify).delete
    @past_supplements =  SubUser.find(params[:sub_user_id]).past_sup
    @sub_user =  SubUser.find(params[:sub_user_id])
    @sub_user.past_sup << selected.current_supplement
    set_time_memo = PastSupplement.order("created_at").last
    set_time_memo.update(from: selected.from, to: params[:to] ? params[:to] : Time.zone.now, memo: selected.memo, when: selecte.when, how: selected.how)
    render json: @sub_user.past_supplements
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_supplement
      if current_user.has_role? "admin"
        @current_supplement = SubUser.find(params[:sub_user_id]).current_sup
      else
        if current_user.sub_user_ids.include? params[:sub_user_id].to_i
          @current_supplement = SubUser.find(params[:sub_user_id]).current_sup
        else
          render json: { errors: "잘못된 접근입니다." }, status: :bad_request
          return
        end
      end
    end

    def update_current_supplement
      @current_supplement_params = params.permit(:from, :to, :memo)
      if current_user.sub_user_ids.include? params[:sub_user_id].to_i
        @current_supplement = SubUser.find(params[:sub_user_id]).current_supplements.find(params[:id])
      end
    end

    def id_to_modify
      @id_to_modify = params[:id]
    end


    def search_id
      @search_id = params[:search_id]
    end

end
