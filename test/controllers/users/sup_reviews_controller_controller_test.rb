class SupReviewsControllerController < ApplicationController
  before_action :authenticate_request!
  before_action :set_sup, only: [:show, :update, :destroy]

  def index
      @reviews = sup.reviews
      render json: @reviews
  end


  def create
      @review = sup.reviews.build(review_params)
      @review.user = current_user
      if @review.save
          render json: { stauts: 'Review created successfully' }, status: :created
      else
          render json: { errors: @review.errors.full_messages }, status: :bad_request
      end 
  end

  def update
      @review = SupReview.find(params[:id])
      if @review.update(review_params)
          render json: sup.reviews
      else
          render json: @review.errors, status: :unprocessable_entity
      end
  end

  def destroy
      SupReview.find(params[:id]).destroy
  end

  private

  def review_params
      params.permit(:efficacy, :side_effect, :body, :pics)
  end

  def set_sup
      sup = Supplement.where(id: params[:drug_id]).first
  end
end
