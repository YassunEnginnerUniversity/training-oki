# == Schema Information
#
# Table name: ticket_views
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :ticket_view do
    user { nil }
    event { nil }
  end
end
