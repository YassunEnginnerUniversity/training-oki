FactoryBot.define do
  factory :organizer do
    sequence(:name) { |n| "興行主#{('A'..'Z').to_a[n - 1]}" }
  end
end
