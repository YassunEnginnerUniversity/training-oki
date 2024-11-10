json.extract! @post, :id, :content

json.user do
  json.id @post.user.id
  json.username @post.user.username
end
json.likes_count @post.likes.count

json.comments @post.comments do |comment|
  json.id comment.id
  json.content comment.content
  json.user do
    json.id comment.user.id
    json.username comment.user.username
  end
end
