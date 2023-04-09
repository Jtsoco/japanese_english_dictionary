class AddPrivateApiKeyCiphertextToUsers < ActiveRecord::Migration[7.0]
  def change
    # This is for the encrypted data
    add_column :users, :private_api_key_ciphertext, :text
    # This is for blind_index
    add_column :users, :private_api_key_bidx, :string
    add_index :users, :private_api_key_bidx, unique: true
  end
end
