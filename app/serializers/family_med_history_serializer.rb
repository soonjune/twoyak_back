class FamilyMedHistorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :sub_user_id, :med_his_id
  attribute :disease do |object|
    "#{object.med_his.as_json}"
  end

  belongs_to :sub_user
  belongs_to :med_his, record_type: :disease
end
