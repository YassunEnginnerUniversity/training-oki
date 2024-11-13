# == Schema Information
#
# Table name: follow_users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_follow_users_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
FactoryBot.define do
  factory :follow_user do
    follower_id { 1 }
    followed_id { 1 }
  end
end
