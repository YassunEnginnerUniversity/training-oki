json.array! @posts do |post|
  json.id post.id
  json.content post.content
  json.user do
    json.id post.user.id
    json.username post.user.username
  end
  json.likes_count post.likes.count
  json.comments_count post.comments.count
end
