class WatchDrugSerializer
  include FastJsonapi::ObjectSerializer
  attribute :drug_names do |object|
    "#{object.watch_drug.name}"
  end

  belongs_to :user
  belongs_to :watch_drug, record_type: :drug
end
