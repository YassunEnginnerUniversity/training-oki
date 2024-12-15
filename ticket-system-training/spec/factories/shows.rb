FactoryBot.define do
  factory :show do
    name { "MyString" }
    start_datetime { "2024-12-14 12:28:57" }
    end_datetime { "2024-12-14 12:28:57" }
    details { "MyText" }
    organizer { nil }
    play_guide { nil }
  end
end
