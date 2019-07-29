class DrugReviewsController < ApplicationController
  before_action :set_drug_review, only: [:show]
  before_action :authenticate_request!, only: [:all, :create, :update, :destroy, :my_reviews]
  before_action :authority_check, only: [:update, :destroy]


  #전체 보여주기
  def all
    if current_user.has_role? "admin"
      @result = DrugReview.all
      render json: @result
    else
      render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
    end
  end

  #최근 리뷰 보여주기
  def recent
    @result = []
    @drug_reviews = DrugReview.order("id DESC").limit(100)
    @drug_reviews.map { |review|
      temp = review.as_json
      temp["drug"] = Drug.find(review.drug_id).name
      user = (User.exists?(review.user_id) ? User.find(review.user_id) : nil )
      if !user.nil?
        temp["user_email"] = user.email.sub(/\A(....)(.*)\z/) { 
          $1 + "*"*4
        }
        if (user_info = user.user_infos.first)
          temp["sex"] = user_info.sex unless user_info.sex.nil?
          temp["age"] = age_range(age(user_info.birth_date)) unless user_info.birth_date.nil?
          temp["diseases"] = user_info.current_disease.pluck(:name)
        end
      else
        temp["user_email"] = "탈퇴한 회원입니다"
      end

      temp["adverse_effects"] = review.adverse_effects.select(:id, :symptom_name)
      temp["liked_users"] = review.l_users.count
      @result << temp
    }

    render json: @result
  end

  def high_rating
    @result = []
    @drug_reviews = DrugReview.order(efficacy: :desc).limit(100).order(id: :desc)
    @drug_reviews.map { |review|
      temp = review.as_json
      temp["drug"] = Drug.find(review.drug_id).name
      user = (User.exists?(review.user_id) ? User.find(review.user_id) : nil )
      if !user.nil?
        temp["user_email"] = user.email.sub(/\A(....)(.*)\z/) { 
          $1 + "*"*4
        }
        if (user_info = user.user_infos.first)
          temp["sex"] = user_info.sex unless user_info.sex.nil?
          temp["age"] = age_range(age(user_info.birth_date)) unless user_info.birth_date.nil?
          temp["diseases"] = user_info.current_disease.pluck(:name)
        end
      else
        temp["user_email"] = "탈퇴한 회원입니다"
      end

      temp["adverse_effects"] = review.adverse_effects.select(:id, :symptom_name)
      temp["liked_users"] = review.l_users.count
      @result << temp
    }

    render json: @result
  end

  def popular
    @result = []
    @drug_reviews = DrugReview.order(drug_review_likes_count: :desc).limit(100)
    @drug_reviews.map { |review|
      temp = review.as_json
      temp["drug"] = Drug.find(review.drug_id).name
      user = (User.exists?(review.user_id) ? User.find(review.user_id) : nil )
      if !user.nil?
        temp["user_email"] = user.email.sub(/\A(....)(.*)\z/) { 
          $1 + "*"*4
        }
        if (user_info = user.user_infos.first)
          temp["sex"] = user_info.sex unless user_info.sex.nil?
          temp["age"] = age_range(age(user_info.birth_date)) unless user_info.birth_date.nil?
          temp["diseases"] = user_info.current_disease.pluck(:name)
        end
      else
        temp["user_email"] = "탈퇴한 회원입니다"
      end

      temp["adverse_effects"] = review.adverse_effects.select(:id, :symptom_name)
      temp["liked_users"] = review.l_users.count
      @result << temp
    }

    render json: @result
  end

  def my_reviews
    @result = []
    @drug_reviews = current_user.drug_reviews
    @drug_reviews.map { |review|
      temp = review.as_json
      temp["drug"] = Drug.find(review.drug_id).name
      user = (User.exists?(review.user_id) ? User.find(review.user_id) : nil )
      if !user.nil?
        temp["user_email"] = user.email.sub(/\A(....)(.*)\z/) { 
          $1 + "*"*4
        }
        if (user_info = user.user_infos.first)
          temp["sex"] = user_info.sex unless user_info.sex.nil?
          temp["age"] = age_range(age(user_info.birth_date)) unless user_info.birth_date.nil?
          temp["diseases"] = user_info.current_disease.pluck(:name)
        end
      else
        temp["user_email"] = "탈퇴한 회원입니다"
      end

      temp["adverse_effects"] = review.adverse_effects.select(:id, :symptom_name)
      temp["liked_users"] = review.l_users.count
      @result << temp
    }

    render json: @result
  end

  # GET /:drug_id/drug_reviews
  def index
    @result = []
    @drug_reviews = DrugReview.where(drug_id: params[:drug_id])
    @drug_reviews.map { |review|
      temp = review.as_json
      user = (User.exists?(review.user_id) ? User.find(review.user_id) : nil )
      if !user.nil?
        temp["user_id"] = user.id
        temp["user_email"] = user.email.sub(/\A(....)(.*)\z/) { 
          $1 + "*"*4
        }
        if (user_info = user.user_infos.first)
          temp["sex"] = user_info.sex unless user_info.sex.nil?
          temp["age"] = age_range(age(user_info.birth_date)) unless user_info.birth_date.nil?
          temp["diseases"] = user_info.current_disease.pluck(:name)
        end
      else
        temp["user_email"] = "탈퇴한 회원입니다"
      end

      temp["adverse_effects"] = review.adverse_effects.select(:id, :symptom_name)
      temp["liked_users"] = review.l_users.count

      @result << temp
    }

    render json: @result
  end

  # GET /drug_reviews/1
  def show
    @result = Hash.new
    @result = @drug_review.attributes
    @result["liked_users"] = @drug_review.l_users.count
    render json: @result
  end

  # POST /drug_reviews
  def create
    if drug_review_params[:user_id] == current_user.id
      @drug_review = DrugReview.new(drug_review_params)
      @drug_review.adverse_effect_ids = drug_review_params[:adverse_effect_ids]
    else
      render json: { errors: ['리뷰 작성 권한이 없습니다.'] }, status: :unauthorized
      return
    end
    if @drug_review.save
      render json: @drug_review, status: :created, location: drug_drug_review_url(id: @drug_review.id)
    else
      render json: @drug_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drug_reviews/1
  def update
    if @drug_review.update(drug_review_params)
      @drug_review.adverse_effect_ids = drug_review_params[:adverse_effect_ids]
      render json: @drug_review
    else
      render json: @drug_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drug_reviews/1
  def destroy
    @drug_review.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_review
      @drug_review = DrugReview.find(params[:id])
    end

    def authority_check
      if current_user.has_role? "admin"
        @drug_review = DrugReview.find(params[:id])
      else
        if current_user.drug_review_ids.include? params[:id].to_i
          @drug_review = DrugReview.find(params[:id])
        end
      end
    end

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

    # Only allow a trusted parameter "white list" through.
    def drug_review_params
      params.require(:drug_review).permit(:user_id, :drug_id, :body, :efficacy, :adverse_effect_ids => [])
    end
end