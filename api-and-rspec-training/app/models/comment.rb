class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true  # コメント内容の必須バリデーション
end
