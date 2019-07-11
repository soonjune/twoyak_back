class CurrentSupplement < ApplicationRecord
    belongs_to :sub_user
    belongs_to :current_supplement, :class_name => "Supplement"
end
