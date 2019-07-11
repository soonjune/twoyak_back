class PastDisease < ApplicationRecord
  belongs_to :sub_user
  belongs_to :past_disease, :class_name => "Disease"
end
