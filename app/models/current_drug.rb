class CurrentDrug < ApplicationRecord
    belongs_to :user_info
    belongs_to :current_drug, :class_name => "Drug"
end
