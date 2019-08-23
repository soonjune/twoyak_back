class DrugSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :drug_rating, :dur_info
end
