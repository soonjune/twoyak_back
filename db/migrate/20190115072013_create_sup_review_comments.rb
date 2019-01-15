class CreateSupReviewComments < ActiveRecord::Migration[5.2]
  def change
    create_table :sup_review_comments do |t|
      t.references :user, foreign_key: true
      t.references :sup_review, foreign_key: true
      t.text :body
      t.integer :likes

      t.timestamps
    end
  end
end
