class PastSupplement < ApplicationRecord
    belongs_to :user_info
    belongs_to :past_supplement, :class_name => "Supplement"
end
