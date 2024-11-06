class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  validates :username, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
