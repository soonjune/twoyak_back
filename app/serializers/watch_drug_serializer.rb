class WatchDrugSerializer
  include FastJsonapi::ObjectSerializer
  attribute :name do |object|
    "#{object.watch_drug.name}"
  end

  belongs_to :user
  belongs_to :watch_drug, record_type: :drug
end
