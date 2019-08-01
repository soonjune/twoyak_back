class DrugReviewLike < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
  belongs_to :drug_review, :counter_cache => true
=======
  belongs_to :drug_review
>>>>>>> master
end
