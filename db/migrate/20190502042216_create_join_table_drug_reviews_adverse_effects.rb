class CreateJoinTableDrugReviewsAdverseEffects < ActiveRecord::Migration[5.2]
  def change
    create_join_table :drug_reviews, :adverse_effects do |t|
      t.index [:drug_review_id, :adverse_effect_id], name: :drug_reviews_and_adverse_effects
      # t.index [:adverse_effect_id, :drug_review_id]
    end
  end
end
