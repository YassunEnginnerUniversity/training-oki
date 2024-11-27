json.extract! @user, :id, :username, :created_at, :updated_at
json.posts @user.posts do |post|
  json.id post.id
  json.content post.content
  json.likes_count post.likes.count
end
json.likes @user.likes do |like|
  json.post_id like.post_id
end
json.followers_count @user.followers.count
json.following_count @user.followings.count
json.is_followed_by_current_user @user.followers.exists?(id: @current_user.id)
