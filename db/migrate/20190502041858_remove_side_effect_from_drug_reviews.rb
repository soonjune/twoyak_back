class RemoveSideEffectFromDrugReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :drug_reviews, :side_effect, :integer
  end
end
