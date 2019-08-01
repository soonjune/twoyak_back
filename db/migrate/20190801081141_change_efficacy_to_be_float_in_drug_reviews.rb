class ChangeEfficacyToBeFloatInDrugReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :drug_reviews, :efficacy, :float
  end
end
