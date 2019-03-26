class AdminController < ApplicationController
    before_action :authenticate_request!
    before_action :is_admin?
  
    def index
      @photos = PrescriptionPhoto.all
    end
  
    def insert
      drug_to_insert = Drug.find(insert_params[:drug_id])
      user_info_insert = UserInfo.find(insert_params[:user_info_id]).currents << drug_to_insert
    end
  
    private
  
    def insert_params
      params.permit(:user_info_id, :drug_id)
    end
  
    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['리뷰 작성 권한이 없습니다.'] }, status: :unauthorized
      end
    end
  end