class PastSupplement < ApplicationRecord
    belongs_to :sub_user
    belongs_to :past_supplement, :class_name => "Supplement"
end
