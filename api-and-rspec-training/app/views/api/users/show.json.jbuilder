json.extract! @user, :id, :username
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
