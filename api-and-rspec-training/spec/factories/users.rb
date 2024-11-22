# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { "testuser" }
    password { "password" }

    trait :other_user do
      username { "otheruser" }
      password { "otherpassword" }
    end

    trait :another_user do
      username { "another" }
      password { "anotherpassword" }
    end

    trait :guest_user do
      username { "guestuser" }
      password { "guestpassword" }
    end
  end
end
