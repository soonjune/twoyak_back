class DrugReview < ApplicationRecord
    belongs_to :user
    belongs_to :drug
    #리뷰 댓글 남기기
    has_many :comments, :class_name => "DrugReviewComment"
end
