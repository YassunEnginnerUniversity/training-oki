FactoryBot.define do
  factory :seat do
    seat_area { "MyString" }
    seat_number { 1 }
    ticket { nil }
  end
end
