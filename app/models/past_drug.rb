class PastDrug < ApplicationRecord
    belongs_to :sub_user
    belongs_to :past_drug, :class_name => "Drug"
end
