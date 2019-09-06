class DiseaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
