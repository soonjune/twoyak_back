class AddDrugReviewLikesCountToDrugReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :drug_reviews, :drug_review_likes_count, :integer, default: 0
  end
end
