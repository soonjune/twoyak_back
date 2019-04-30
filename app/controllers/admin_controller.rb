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

    def user_analysis
      @data_sent = []
      user_infos = UserInfo.all
      user_infos.map { |user_info|
        @past_diseases = []
        user_info.past_diseases.each { |d|
          @past_diseases << { id: d.id, parent_id: d.past_disease.id, name: d.past_disease.name, from: d.from, to: d.to }
        }
        @current_diseases = []
        user_info.current_diseases.each { |d|
          @current_diseases << { id: d.id, parent_id: d.current_disease.id, name: d.current_disease.name, from: d.from, to: d.to }
        }
        user_info.past_drugs.each { |d|
          @past_drugs << { id: d.id, parent_id: d.past_drug.id, name: d.past_drug.name, from: d.from, to: d.to, memo: d.memo }
        }
        user_info.current_drugs.each { |d|
          @current_drugs << { id: d.id, parent_id: d.current_drug.id, name: d.current_drug.name, from: d.from, to: d.to, memo: d.memo  }
        }
        info_data = { user_info: { basic_info: user_info, family_med_his: user_info.med_his.select(:id, :name), past_diseases: @past_diseases, 
          current_diseases: @current_diseases, 
          past_drugs: @past_drugs, 
          current_drugs: @current_drugs}
        }
          #각각의 데이터를 넣어줌
          infos << info_data
        @data_sent[:infos] = infos
        @data_sent[:watch_drugs] = current_user.watch_drug
        @data_sent[:watch_supplements] = current_user.watch_supplement
        @data_sent[:drug_reviews] = current_user.drug_reviews
        @data_sent[:sup_reviews] = current_user.sup_reviews
      }

      render json: @data_sent

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