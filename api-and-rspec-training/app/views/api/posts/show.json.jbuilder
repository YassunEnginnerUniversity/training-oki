json.extract! @post, :id, :content, :created_at, :updated_at

json.user do
  json.id @post.user.id
  json.username @post.user.username
end
json.likes_count @post.likes.count
json.is_liked_by_current_user @post.likes.exists?(user_id: @current_user.id)
json.comments @post.comments.order(created_at: :desc) do |comment|
  json.id comment.id
  json.content comment.content
  json.created_at comment.created_at
  json.updated_at comment.updated_at
  json.user do
    json.id comment.user.id
    json.username comment.user.username
  end
end
