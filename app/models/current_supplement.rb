class CurrentSupplement < ApplicationRecord
    belongs_to :user_info
    belongs_to :current_supplement, :class_name => "Supplement"
end
