class CreateDrugReviewLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_review_likes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :drug_review, foreign_key: true

      # t.timestamps
    end
  end
end
