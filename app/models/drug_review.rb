class DrugReview < ApplicationRecord
    belongs_to :user
    belongs_to :drug
    #리뷰 댓글 남기기
    has_many :comments, :class_name => "DrugReviewComment"
    validates :drug_id, uniqueness: { scope: :user_id, message: "이미 이 약에 대한 리뷰를 작성하셨습니다." }
end
