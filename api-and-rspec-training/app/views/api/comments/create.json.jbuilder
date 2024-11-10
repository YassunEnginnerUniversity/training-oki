json.extract! @comment, :id, :content
json.post_id @comment.post_id
json.user do
  json.id @comment.user.id
  json.username @comment.user.username
end
json.created_at @comment.created_at
