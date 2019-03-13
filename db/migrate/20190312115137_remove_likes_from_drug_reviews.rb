class RemoveLikesFromDrugReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :drug_reviews, :likes, :integer
    remove_column :sup_reviews, :likes, :integer
  end
end
