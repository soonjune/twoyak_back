class DrugReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :efficacy, :body, :drug_review_likes_count

  belongs_to :user
  belongs_to :drug
  #리뷰 댓글 남기기
  has_many :comments, :class_name => "DrugReviewComment"
  has_many :adverse_effects

  #리뷰 좋아요
  has_many :drug_review_likes
  has_many :l_users, through: :drug_review_likes, source: :user
end
