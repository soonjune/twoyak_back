class FamilyMedHistorySerializer
  include FastJsonapi::ObjectSerializer
  # attributes :id, :sub_user_id, :med_his_id
  attribute :name do |object|
    "#{object.med_his.name}"
  end
  attribute :disease_id do |object|
    object.med_his.id
  end

  # belongs_to :sub_user
  # belongs_to :med_his, record_type: :disease
end
