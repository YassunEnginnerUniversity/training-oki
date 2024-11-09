json.extract! @user_post, :id, :content
json.user do
  json.id @user_post.user.id
  json.username @user_post.user.username
end
json.likes_count @user_post.likes.count
json.comments @user_post.comments do |comment|
  json.id comment.id
  json.content comment.content
  json.user do
    json.id comment.user.id
    json.username comment.user.username
  end
end
