# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  used_time      :datetime
#  transfer_time  :datetime
#  ticket_type_id :integer          not null
#  entrance_id    :integer          not null
#  ticket_view_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :ticket do
    used_time { "2024-12-14 12:30:06" }
    transfer_time { "2024-12-14 12:30:06" }
    ticket_type { nil }
    entrance { nil }
    ticket_view { nil }
  end
end
