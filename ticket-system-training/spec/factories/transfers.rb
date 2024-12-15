FactoryBot.define do
  factory :transfer do
    from_user_id { 1 }
    to_user_id { 1 }
    ticket_view { nil }
  end
end
