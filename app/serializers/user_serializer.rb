class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  attributes :id, :email
  meta do |user|
    {
      user.watch_drugs
    }
  end

  has_many :sub_users
  #의약품/건강기능식품 리뷰
  has_many :drug_reviews
  has_many :sup_reviews
  #리뷰 댓글 남기기
  # has_many :drug_review_comments
  # has_many :sup_review_comments

  #건의 사항 남기기
  has_many :suggestions, dependent: :destroy 

  #관심 의약품/건강기능식품
  # has_many :watch_drugs
  # has_many :watch_drug, :through => :watch_drugs
  # has_many :watch_supplements
  # has_many :watch_supplement, :through => :watch_supplements

  has_many :identities, dependent: :destroy

  #리뷰 좋아요
  has_many :drug_review_likes
  has_many :l_drug_reviews, through: :drug_review_likes, source: :drug_review
end
