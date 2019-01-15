class AddColumnsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :drug_reviews, :likes, :integer
    add_column :sup_reviews, :likes, :integer
  end
end
