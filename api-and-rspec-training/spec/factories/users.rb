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
  end
end