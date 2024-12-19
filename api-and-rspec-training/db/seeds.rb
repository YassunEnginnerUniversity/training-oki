# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
User.destroy_all
Post.destroy_all
Like.destroy_all
Comment.destroy_all
FollowUser.destroy_all

# Create users
users = []
10.times do |i|
  users << User.create!(
    username: "user_#{i + 1}",
    password: "password"
  )
end

# Create posts
posts = []
users.each do |user|
  3.times do
    posts << user.posts.create!(
      content: "This is a post by #{user.username}"
    )
  end
end

# Create comments
posts.each do |post|
  5.times do
    Comment.create!(
      content: "This is a comment on post #{post.id}",
      user: users.sample,
      post: post
    )
  end
end

# Create likes
posts.each do |post|
  users.sample(3).each do |user|
    Like.create!(
      user: user,
      post: post
    ) rescue nil
  end
end

# Create follow relationships
users.each do |follower|
  users.sample(3).each do |followed|
    next if follower == followed # 自分自身のフォローをスキップ

    FollowUser.create!(
      follower: follower,
      followed: followed
    ) rescue nil
  end
end

puts 'Seeding completed successfully!'
