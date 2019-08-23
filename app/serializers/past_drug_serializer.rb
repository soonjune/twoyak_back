class PastDrugSerializer
  include FastJsonapi::ObjectSerializer
  attributes :sub_user_id, :past_drug_id, :when, :how, :from, :to, :memo
  attribute :drug do |past_drug|
    DrugSerializer.new(Drug.find(past_drug.past_drug_id))
  end
  attribute :diseases do |past_drug|
    DiseaseSerializer.new(current_drug.diseases.limit(1)).serializable_hash[:data].first
  end
  attribute :my_review do |past_drug, params|
    DrugReviewSerializer.new(DrugReview.where(user_id: params[:current_user].id, drug_id: past_drug.past_drug_id), {params: {liked_drug_reviews: params[:current_user].l_drug_review_ids}})
  end
end
