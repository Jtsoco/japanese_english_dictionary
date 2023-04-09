class RemoveColumnApiTokenFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :api_token
  end
end
