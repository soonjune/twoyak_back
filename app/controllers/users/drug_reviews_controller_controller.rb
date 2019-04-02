#어디서 왔는지 잘 모르겠으나 일단 남겨둠(20190402)

class DrugReviewsControllerController < ApplicationController
    before_action :authenticate_request!
    before_action :set_drug, only: [:show, :update, :destroy]

    def index
        @reviews = drug.reviews
        render json: @reviews
    end


    def create
        @review = drug.reviews.build(review_params)
        @review.user = current_user
        if @review.save
            render json: { stauts: 'Review created successfully' }, status: :created
        else
            render json: { errors: @review.errors.full_messages }, status: :bad_request
        end 
    end

    def update
        @review = DrugReview.find(params[:id])
        if @review.update(review_params)
            render json: drug.reviews
        else
            render json: @review.errors, status: :unprocessable_entity
        end
    end

    def destroy
        DrugReview.find(params[:id]).destroy
    end

    private

    def review_params
        params.permit(:efficacy, :side_effect, :body)
    end

    def set_drug
        drug = Drug.where(id: params[:drug_id]).first
    end
end
