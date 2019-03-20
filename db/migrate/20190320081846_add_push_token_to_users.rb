class AddPushTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :push_token, :string
  end
end
