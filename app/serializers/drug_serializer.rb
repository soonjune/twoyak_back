class DrugSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :drug_rating
end
