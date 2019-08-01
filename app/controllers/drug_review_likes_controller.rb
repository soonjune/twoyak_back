class DrugReviewLikesController < ApplicationController
    before_action :authenticate_request!

    #좋아요 눌렀는지 확인
    def show
<<<<<<< HEAD
        if current_user.l_drug_reviews.include?(params[:review_id])
=======
        if current_user.l_drug_reviews.include?(params[:id])
>>>>>>> master
            result = true
        else
            result = false
        end
        render json: result
    end

    def like_toggle
<<<<<<< HEAD
        like = DrugReviewLike.find_by(user: current_user, drug_review_id: params[:drug_review_id])
        if like.nil?
            DrugReviewLike.create(user: current_user, drug_review_id: params[:drug_review_id])
            render json: {status: 'ok'}, status: :created
        else
            like.destroy
            render json: {status: 'ok'}, status: :ok
        end
    end

=======
        like = Like.find_by.find_by(user: current_user, drug_review_comment_id: params[:id])
        if like.nil?
            DrugReviewLike.create(user: current_user, drug_review_comment_id: params[:id])
        else
            like.destroy
        end
        render json: {status: 'ok'}, status: :ok
    end
>>>>>>> master
end
