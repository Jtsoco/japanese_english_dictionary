class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_encrypted :private_api_key
  blind_index :private_api_key
  before_create :set_private_api_key

  validates :private_api_key, uniqueness: true, allow_blank: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end
