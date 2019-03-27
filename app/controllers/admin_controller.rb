class AdminController < ApplicationController
    before_action :authenticate_request!
    before_action :is_admin?
    before_action :set_current_drug, only: [:insert]
  
    def index
      @result = Hash.new
      @result["photos"] = PrescriptionPhoto.all.order("id DESC")
      @result["current_drugs"] = []
      temp = CurrentDrug.all.order("created_at DESC").limit(100)
      temp.as_json.map { |drug|
        drug["name"] = Drug.find(drug["current_drug_id"]).name
        @result["current_drugs"] << drug
      }
      render json: @result
    end
  
    def insert
      if @current_drug.include?(Drug.find(insert_params[:drug_id]))
        render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
      elsif @current_drug << Drug.find(insert_params[:drug_id])
        set_time_memo = CurrentDrug.where(user_info_id: insert_params[:user_info_id], current_drug_id: insert_params[:drug_id]).last
        set_time_memo.update(from: insert_params[:from], to: insert_params[:to] ? insert_params[:to] : Time.zone.now, memo: insert_params[:memo], when: insert_params[:whern], how: insert_params[:how])
        render json: @current_drug.pluck(:id, :name), status: :created
      else
        render json: @current_drug.errors, status: :unprocessable_entity
      end
    end
    
    def check
        PrescriptionPhoto.update(check_params)
    end

    def destroy
        CurrentDrug.find(:current_drug_id).delete
    end

    private
  
    def insert_params
      params.permit(:user_info_id, :drug_id, :from, :to, :memo, :when, :how)
    end

    def check_params
      params.permit(:id, :check)
    end
  
    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end

    def set_current_drug
        if current_user.has_role? "admin"
          @current_drug = UserInfo.find(params[:user_info_id]).current_drug
        else
          if current_user.user_info_ids.include? params[:user_info_id].to_i
            @current_drug = UserInfo.find(params[:user_info_id]).current_drug
          else
            render json: { errors: "잘못된 접근입니다." }, status: :bad_request
            return
          end
        end
      end

  end