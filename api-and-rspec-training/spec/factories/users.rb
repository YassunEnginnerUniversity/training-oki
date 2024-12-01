# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  profile         :string
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
    profile { "" }

    trait :other_user do
      username { "otheruser" }
      password { "otherpassword" }
      profile { "" }
    end

    trait :another_user do
      username { "another" }
      password { "anotherpassword" }
      profile { "" }
    end

    trait :guest_user do
      username { "guestuser" }
      password { "guestpassword" }
      profile { "" }
    end
  end
end
