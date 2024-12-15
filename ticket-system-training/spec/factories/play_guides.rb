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
    sequence(:name) { |n| "プレイガイド#{('A'..'Z').to_a[n - 1]}" }
  end
end
