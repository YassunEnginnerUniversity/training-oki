FactoryBot.define do
  factory :ticket_type do
    name { "MyString" }
    price { 1.5 }
    event { nil }
  end
end
