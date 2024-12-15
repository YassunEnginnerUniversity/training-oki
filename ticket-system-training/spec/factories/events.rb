FactoryBot.define do
  factory :event do
    name { "MyString" }
    details { "MyText" }
    date { "2024-12-14" }
    venue { "MyString" }
    open_time { "2024-12-14 12:29:07" }
    start_time { "2024-12-14 12:29:07" }
    end_time { "2024-12-14 12:29:07" }
    notes { "MyText" }
    show { nil }
  end
end
