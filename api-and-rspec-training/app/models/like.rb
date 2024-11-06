class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }  # 同じ投稿に対して一人のユーザーが複数回「いいね」しないようにする
end
