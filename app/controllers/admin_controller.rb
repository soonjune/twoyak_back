class AdminController < ApplicationController
    before_action :authenticate_request!
    before_action :is_admin?
  
    def index
      @photos = PrescriptionPhoto.all.order("id DESC")
      @current_drugs = CurrentDrug.all.order("created_at DESC").limit(100)
    end
  
    def insert
      if @current_drug.include?(insert_params[:drug_id])
        render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
      elsif @current_drug << Drug.find(insert_params[:drug_id])
        set_time_memo = CurrentDrug.where(user_info_id: params[:user_info_id], current_drug_id: @search_id).last
        set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo], when: params[:whern], how: params[:how])
        render json: @current_drug.pluck(:id, :name), status: :created
      else
        render json: @current_drug.errors, status: :unprocessable_entity
      end
    end
    

    def destroy
        CurrentDrug.find(:current_drug_id).delete
    end

    private
  
    def insert_params
      params.permit(:user_info_id, :drug_id)
    end
  
    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end
  end