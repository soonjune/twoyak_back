class CurrentDrugSerializer
  include FastJsonapi::ObjectSerializer
  attributes :sub_user_id, :current_drug_id, :when, :how, :from, :to, :memo
  attribute :drug do |current_drug|
    DrugSerializer.new(Drug.find(current_drug.current_drug_id))
  end
  attribute :disease do |current_drug|
    DiseaseSerializer.new(current_drug.diseases.limit(1)).serializable_hash[:data].first
  end
  attribute :my_review do |current_drug, params|
    DrugReviewSerializer.new(DrugReview.where(user_id: params[:current_user].id, drug_id: current_drug.current_drug_id), {params: {liked_drug_reviews: params[:current_user].l_drug_review_ids}}).serializable_hash[:data].first
  end
end
