class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_follow_users, class_name: "FollowUser", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow_users, class_name: "FollowUser", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_follow_users, source: :followed
  has_many :followers, through: :passive_follow_users, source: :follower

  validates :username, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
