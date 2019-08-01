class CurrentDrug < ApplicationRecord
    belongs_to :sub_user
    belongs_to :current_drug, :class_name => "Drug"
    has_many :drug_taking_reasons, as: :reasonable, dependent: :destroy
    has_many :diseases, through: :drug_taking_reasons
end
