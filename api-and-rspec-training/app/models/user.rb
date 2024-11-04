class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
