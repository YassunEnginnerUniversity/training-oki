# == Schema Information
#
# Table name: play_guides
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :play_guide do
    sequence(:name) { |n| "プレイガイド#{('A'.ord + n - 1).chr}" }
  end
end

