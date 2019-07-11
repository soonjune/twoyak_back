class CurrentDisease < ApplicationRecord
    belongs_to :sub_user
    belongs_to :current_disease, :class_name => "Disease"
end
