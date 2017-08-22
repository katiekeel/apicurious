class AddMoreFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :oauth_token_secret
    add_column :users, :image_url, :string
  end
end
