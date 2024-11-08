FactoryBot.define do
  factory :follow_user do
    follower_id { 1 }
    followed_id { 1 }
  end
end
