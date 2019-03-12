class RemovePicsFromDrugReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :drug_reviews, :pics, :json
  end
end
