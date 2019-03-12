class RemovePicsFromSupReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :sup_reviews, :pics, :json
  end
end
