if @filterName == "followings" && @user_id == @current_user.id
  json.array! @current_user_following_posts do |post|
    json.id post.id
    json.content post.content
    json.user do
      json.id post.user.id
      json.username post.user.username
    end
    json.likes_count post.likes.count
    json.is_liked_by_current_user post.likes.exists?(user_id: @current_user.id)
    json.comments_count post.comments.count
  end
elsif @user_id == @current_user.id
  json.array! @current_user_posts do |post|
    json.id post.id
    json.content post.content
    json.user do
      json.id post.user.id
      json.username post.user.username
    end
    json.likes_count post.likes.count
    json.is_liked_by_current_user post.likes.exists?(user_id: @current_user.id)
    json.comments_count post.comments.count
  end
else
  json.array! @posts do |post|
    json.id post.id
    json.content post.content
    json.user do
      json.id post.user.id
      json.username post.user.username
    end
    json.likes_count post.likes.count
    json.is_liked_by_current_user post.likes.exists?(user_id: @current_user.id)
    json.comments_count post.comments.count
  end
end
