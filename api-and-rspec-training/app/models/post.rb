class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: { message: "内容を入力してください" }, length: { maximum: 255, message: "255字以上は投稿できません" }
end
