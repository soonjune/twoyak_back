class CurrentDisease < ApplicationRecord
    belongs_to :user_info
    belongs_to :current_disease, :class_name => "Disease"
end
