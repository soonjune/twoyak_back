class PastDisease < ApplicationRecord
  belongs_to :user_info
  belongs_to :past_disease, :class_name => "Disease"
end
