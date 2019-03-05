class User::CurrentDiseasesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_disease, :search_id, only: [:create, :show, :destroy, :destroy_to_past]

  # GET /current_diseases
  def index
    @current_diseases = CurrentDisease.all

    render json: @current_diseases
  end

  # GET /current_diseases/1
  def show
    render json: @current_disease
  end

  # POST /current_diseases
  def create
    if @current_disease.include?(Disease.find(@search_id))
      render json: { errors: "이미 앓고 있는 질환입니다." }, status: :unprocessable_entity
    elsif @current_disease << Disease.find(@search_id)
      set_time_memo = CurrentDisease.order("created_at").last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo])
      render json: @current_disease, status: :created
    else
      render json: @current_disease.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /current_diseases/1
  # def update
  #   if @current_disease.update(current_disease_params)
  #     render json: @current_disease
  #   else
  #     render json: @current_disease.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /current_diseases/1
  def destroy
    @current_disease.delete(Disease.find(@search_id))
  end

  def destroy_to_past
    selected = CurrentDisease.find_by(current_disease_id: @search_id)
    @current_disease.delete(Disease.find(@search_id))
    @past_diseases =  UserInfo.find(params[:user_info_id]).past_disease
    @past_diseases << Disease.find(@search_id)
    set_time_memo = PastDisease.order("created_at").last
    set_time_memo.update(from: selected.from, to: params[:to] ? params[:to] : Time.zone.now, memo: selected.memo)
    render json: @past_diseases
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_disease
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_disease = UserInfo.find(params[:user_info_id]).current_disease
      else
        render json: { errors: "잘못된 접근입니다." }, status: :bad_request
        return
      end
    end

    def search_id
      @search_id = params[:search_id]
    end
    
end
