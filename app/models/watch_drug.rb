class WatchDrug < ApplicationRecord
    belongs_to :user
    belongs_to :watch_drug, :class_name => "Drug"
    validates :watch_drug_id, uniqueness: {scope: :user, message: "이미 관심 등록하셨습니다."}
end
