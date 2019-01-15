class SupReviewComment < ApplicationRecord
  belongs_to :user
  belongs_to :sup_review
end
