class AdminController < ApplicationController
    before_action :authenticate_request!
    before_action :is_admin?
  
    def index
      @photos = PrescriptionPhoto.all.order("id DESC")
      @current_drugs = CurrentDrug.all.order("created_at DESC").limit(100)
    end
  
<<<<<<< HEAD
    def insert
      if @current_drug.include?(insert_params[:drug_id])
        render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
      elsif @current_drug << Drug.find(insert_params[:drug_id])
        set_time_memo = CurrentDrug.where(sub_user_id: params[:sub_user_id], current_drug_id: @search_id).last
        set_time_memo.update(from: params[:from] ? params[:from] : Time.zone.now, to: params[:to], memo: params[:memo], when: params[:whern], how: params[:how])
        render json: @current_drug.pluck(:id, :name), status: :created
      else
        render json: @current_drug.errors, status: :unprocessable_entity
      end
=======
    # def insert
    #   if @current_drug.include?(Drug.find(insert_params[:drug_id]))
    #     render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
    #   elsif @current_drug << Drug.find(insert_params[:drug_id])
    #     set_time_memo = CurrentDrug.where(user_info_id: insert_params[:user_info_id], current_drug_id: insert_params[:drug_id]).last
    #     set_time_memo.update(from: insert_params[:from], to: insert_params[:to] ? insert_params[:to] : Time.zone.now, memo: insert_params[:memo], when: insert_params[:whern], how: insert_params[:how])
    #     render json: @current_drug.pluck(:id, :name), status: :created
    #   else
    #     render json: @current_drug.errors, status: :unprocessable_entity
    #   end
    # end

    def user_analysis
      @data_sent = Hash.new
      user_infos = UserInfo.all
      infos = []
      user_infos.map { |user_info|
        @past_diseases = []
        user_info.past_diseases.each { |d|
          @past_diseases << { id: d.id, parent_id: d.past_disease.id, name: d.past_disease.name, from: d.from, to: d.to }
        }
        @current_diseases = []
        user_info.current_diseases.each { |d|
          @current_diseases << { id: d.id, parent_id: d.current_disease.id, name: d.current_disease.name, from: d.from, to: d.to }
        }
        @past_drugs = []
        user_info.past_drugs.each { |d|
          @past_drugs << { id: d.id, parent_id: d.past_drug.id, name: d.past_drug.name, drug_class: if !d.past_drug.package_insert.nil? then d.past_drug.package_insert["DRB_ITEM"]["CLASS_NO"] else "분류 없음" end, from: d.from, to: d.to, memo: d.memo }
        }
        @current_drugs = []
        user_info.current_drugs.each { |d|
          @current_drugs << { id: d.id, parent_id: d.current_drug.id, name: d.current_drug.name, drug_class: if !d.current_drug.package_insert.nil? then d.current_drug.package_insert["DRB_ITEM"]["CLASS_NO"] else "분류 없음" end, from: d.from, to: d.to, memo: d.memo  }
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

    def check
        pr_to_change = PrescriptionPhoto.find(check_params[:id])
        pr_to_change.check = check_params[:check]
        pr_to_change.save
>>>>>>> master
    end

    def user_analysis
      @data_sent = Hash.new
      sub_users = SubUser.all
      infos = []
      sub_users.map { |sub_user|
        @past_diseases = []
        sub_user.past_diseases.each { |d|
          @past_diseases << { id: d.id, parent_id: d.past_disease.id, name: d.past_disease.name, from: d.from, to: d.to }
        }
        @current_diseases = []
        sub_user.current_diseases.each { |d|
          @current_diseases << { id: d.id, parent_id: d.current_disease.id, name: d.current_disease.name, from: d.from, to: d.to }
        }
        @past_drugs = []
        sub_user.past_drugs.each { |d|
          @past_drugs << { id: d.id, parent_id: d.past_drug.id, name: d.past_drug.name, drug_class: d.past_drug.package_insert["DRB_ITEM"]["CLASS_NO"], from: d.from, to: d.to, memo: d.memo }
        }
        @current_drugs = []
        sub_user.current_drugs.each { |d|
          @current_drugs << { id: d.id, parent_id: d.current_drug.id, name: d.current_drug.name, drug_class: d.current_drug.package_insert["DRB_ITEM"]["CLASS_NO"], from: d.from, to: d.to, memo: d.memo  }
        }
        info_data = { sub_user: { basic_info: sub_user, family_med_his: sub_user.med_his.select(:id, :name), past_diseases: @past_diseases, 
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
      params.permit(:sub_user_id, :drug_id)
    end
  
    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end
  end