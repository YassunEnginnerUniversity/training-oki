# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ユーザ#{('A'.ord + n - 1).chr}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password#{('A'.ord + rand(0..25)).chr}" }
  end
end
