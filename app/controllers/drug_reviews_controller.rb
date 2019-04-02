class DrugReviewsController < ApplicationController
  before_action :set_drug_review, only: [:show]
  before_action :authenticate_request!, only: [:create, :update, :destroy]
  before_action :authority_check, only: [:update, :destroy]


  #최근 리뷰 보여주기
  def recent
    @drug_reviews = DrugReview.order("id DESC").limit(20)

    render json: @drug_reviews
  end

  # GET /:drug_id/drug_reviews
  def index
    @result = []
    @drug_reviews = DrugReview.where(drug_id: params[:drug_id])
    @drug_reviews.map { |review|
      temp = Hash.new
      temp["id"] = review.id
      user = User.find(review.user_id)
      user_info = user.user_infos.first
      temp["user_email"] = user.email
      temp["sex"] = user_info.sex
      temp["birth_date"] = user_info.birth_date
      temp["diseases"] = user_info.current_disease.pluck(:name)
      temp["efficacy"] = review.efficacy
      temp["side_effect"] = review.side_effect
      temp["body"] =review.body
      @result << temp
    }

    render json: @result
  end

  # GET /drug_reviews/1
  def show
    render json: @drug_review
  end

  # POST /drug_reviews
  def create
    if drug_review_params[:user_id] == current_user.id
      @drug_review = DrugReview.new(drug_review_params)
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

    # Only allow a trusted parameter "white list" through.
    def drug_review_params
      params.require(:drug_review).permit(:user_id, :drug_id, :body, :efficacy, :side_effect)
    end
end
