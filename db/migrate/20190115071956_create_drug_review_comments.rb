class CreateDrugReviewComments < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_review_comments do |t|
      t.references :user, foreign_key: true
      t.references :drug_review, foreign_key: true
      t.text :body
      t.integer :likes

      t.timestamps
    end
  end
end
