class User::PastDiseasesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_disease, :search_id, only: [:create, :show, :destroy]
  before_action :update_past_disease, only: [:update]
  before_action :id_to_modify, only: [:update, :destroy]

  # GET /past_diseases
  def index
    @past_diseases = PastDisease.all

    render json: @past_diseases
  end

  # GET /past_diseases/1
  def show
    render json: @past_disease
  end

  # POST /past_diseases
  def create
    if @past_disease << Disease.find(@search_id)
      set_time_memo = PastDisease.where(sub_user_id: params[:sub_user_id], past_disease_id: @search_id).last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now)
      render json: @past_disease, status: :created
    else
      render json: @past_disease.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /past_diseases/1
  def update
    if @past_disease.update(@past_disease_params)
      render json: @past_disease
    else
      render json: @past_disease.errors, status: :unprocessable_entity
    end
  end

  # DELETE /past_diseases/1
  def destroy
    PastDisease.find(@id_to_modify).delete
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_disease
      if current_user.has_role? "admin"
        @past_disease = SubUser.find(params[:sub_user_id]).past_disease
      else
        if current_user.sub_user_ids.include? params[:sub_user_id].to_i
          @past_disease = SubUser.find(params[:sub_user_id]).past_disease
        else
          render json: { errors: "잘못된 접근입니다." }, status: :bad_request
          return
        end
      end
    end

    def update_past_disease
      @past_disease_params = params.permit(:from, :to)
      if current_user.sub_user_ids.include? params[:sub_user_id].to_i
        @past_disease = SubUser.find(params[:sub_user_id]).past_diseases.find(params[:id])
      end
    end

    def id_to_modify
      @id_to_modify = params[:id]
    end


    def search_id
      @search_id = params[:search_id]
    end
end
