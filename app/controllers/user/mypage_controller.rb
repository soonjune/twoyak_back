class User::MypageController < ApplicationController
  before_action :authenticate_request!
  before_action :set_user_info, only: [:create, :update, :destroy]

  def create
    @user_info = current_user.user_infos.create(user_info_params)

    if @user_info.save
      render json: @user_info, status: :created, location: @user_info
    else
      render json: @user_info.errors, status: :unprocessable_entity
    end 
  end

  def index
    user_infos = current_user.user_infos
    @data_sent = Hash.new
    infos = []
    user_infos.each { |user_info|
      #각각의 이력 정렬
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
        @past_drugs << { id: d.id, parent_id: d.past_drug.id, name: d.past_drug.name, from: d.from, to: d.to, memo: d.memo }
      }
      @current_drugs = []
      user_info.current_drugs.each { |d|
        @current_drugs << { id: d.id, parent_id: d.current_drug.id, name: d.current_drug.name, from: d.from, to: d.to, memo: d.memo  }
      }
      @past_supplements = []
      user_info.past_supplements.each { |d|
        @past_supplements << { id: d.id, parent_id: d.past_supplement.id, name: d.past_supplement.name, from: d.from, to: d.to, memo: d.memo  }
      }
      @current_supplements = []
      user_info.current_supplements.each { |d|
        @current_supplements << { id: d.id, parent_id: d.current_supplement.id, name: d.current_supplement.name, from: d.from, to: d.to, memo: d.memo  }
      }

      info_data = { user_info: { basic_info: user_info, family_med_his: user_info.med_his.select(:id, :name), past_diseases: @past_diseases, 
      current_diseases: @current_diseases, 
      past_drugs: @past_drugs, 
      current_drugs: @current_drugs,
      past_supplements: @past_supplements,
      current_supplements: @current_supplements }
      }
      #각각의 데이터를 넣어줌
      infos << info_data
    }
    @data_sent[:infos] = infos
    @data_sent[:watch_drugs] = current_user.watch_drug
    @data_sent[:watch_supplements] = current_user.watch_supplement
    @data_sent[:drug_reviews] = current_user.drug_reviews
    @data_sent[:sup_reviews] = current_user.sup_reviews
    
    render json: @data_sent
  end

  def update
    if @user_info.update(user_info_params)
  end

  def destroy
    @user_info.destroy
  end

  private

  def set_user_info
    @user_info = UserInfo.find(params[:id])
  end

  def user_info_params
    params.require([:user_info]).permit(:id, :user_name, :profile_image, :birth_date, :drink, :smoke, :caffeine)
  end

  # def update_params
  #   params.require([:user_info, :family_med_his, :past_disease, :current_disease, :past_drug, :current_drug, :past_supplement]).permit(:id, :profile_image, :birth_date, :drink, :smoke, :caffeine, :disease_name, :past_disease, :current_diseases, :past_supplement,:current_supplement)
  end

end
