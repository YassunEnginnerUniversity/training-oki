FactoryBot.define do
  factory :play_guide do
    sequence(:name) { |n| "プレイガイド#{('A'..'Z').to_a[n - 1]}" }
  end
end
