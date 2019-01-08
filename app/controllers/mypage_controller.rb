class MypageController < ApplicationController
  before_action :authenticate_request!

  def create
  end

  def show
    user_infos = current_user.user_infos
    @data_sent = Hash.new
    infos = []
    user_infos.each { |user_info|
      info_data = { user_info: { basic_info: user_info, family_med_his: user_info.med_his.pluck(:disease_name), past_diseases: user_info.past_disease.pluck(:disease_name), current_diseases: user_info.current_disease.pluck(:disease_name), past_drugs: user_info.past_drug.pluck(:item_name), current_drugs: user_info.current_drug.pluck(:item_name),  past_supplement: user_info.past_sup.pluck(:product_name), current_supplement: user_info.current_sup.pluck(:product_name) } }
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
  end

  def destroy
  end
end
