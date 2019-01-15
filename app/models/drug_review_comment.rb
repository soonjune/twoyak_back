class DrugReviewComment < ApplicationRecord
  belongs_to :user
  belongs_to :drug_review
end
