class PastDrugSerializer
  include FastJsonapi::ObjectSerializer
  attributes :sub_user_id, :past_drug_id, :when, :how, :from, :to, :memo
  

end
