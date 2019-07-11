class CurrentDrug < ApplicationRecord
    belongs_to :sub_user
    belongs_to :current_drug, :class_name => "Drug"
end
