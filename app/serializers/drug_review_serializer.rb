module AgeHelper
  extend ActiveSupport::Concern

  class_methods do

    def age(dob)
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end    

    def age_range(age)
      if (age % 10) <= 3
        return age.floor(-1).to_s + "대 초반"
      elsif (age % 10) <= 6
        return age.floor(-1).to_s + "대 중반"
      else
        return age.floor(-1).to_s + "대 후반"
      end
    end

  end

end

class DrugReviewSerializer 
  include FastJsonapi::ObjectSerializer
  include AgeHelper

  attributes :id, :efficacy, :body, :drug_review_likes_count
  meta do |drug_review, params|
     user = (!drug_review.user.blank? ? drug_review.user : nil )
     temp = Hash.new
     if !user.nil?
      temp["id"] = user.id
      temp["user_email"] = user.email.sub(/\A(....)(.*)\z/) { 
        $1 + "*"*4
      }
        if (sub_user = user.sub_users.first)
          temp["sex"] = sub_user.sex unless sub_user.sex.nil?
          temp["age"] = age_range(age(sub_user.birth_date)) unless sub_user.birth_date.nil?
          temp["diseases"] = sub_user.current_disease.pluck(:name)
        end
      else
        temp["user_email"] = "탈퇴한 회원입니다"
      end
      #내가 좋아요 했는지
      if params[:liked_drug_reviews].include?(drug_review.id)
        temp["liked"] = true
      else
        temp["liked"] = false
      end

    {
      adverse_effects: drug_review.adverse_effects,
      drug: { id: drug_review.drug.id, name: drug_review.drug.name },
      user: temp,
    }
  end

  # belongs_to :user
  # belongs_to :drug, serializer: DrugSerializer
  # #리뷰 댓글 남기기
  # has_many :comments, :class_name => "DrugReviewComment"
  # has_many :adverse_effects, serializer: AdverseEffectSerializer

  # #리뷰 좋아요
  # has_many :drug_review_likes
  # has_many :l_users, through: :drug_review_likes, source: :user
end
