class PastDrug < ApplicationRecord
    belongs_to :user_info
    belongs_to :past_drug, :class_name => "Drug"
end
