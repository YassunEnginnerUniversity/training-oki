class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: { message: "内容を入力してください" }, length: { maximum: 255, message: "255字以上はコメントできません" }
end
