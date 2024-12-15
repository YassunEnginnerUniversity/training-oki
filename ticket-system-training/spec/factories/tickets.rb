FactoryBot.define do
  factory :ticket do
    used_time { "2024-12-14 12:30:06" }
    transfer_time { "2024-12-14 12:30:06" }
    ticket_type { nil }
    entrance { nil }
    ticket_view { nil }
  end
end
