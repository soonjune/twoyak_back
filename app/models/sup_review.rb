class SupReview < ApplicationRecord
    belongs_to :user
    belongs_to :supplement
    #리뷰 댓글 남기기
    has_many :comments, :class_name => "SupReviewComment"
end
