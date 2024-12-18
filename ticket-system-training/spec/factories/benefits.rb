# == Schema Information
#
# Table name: benefits
#
#  id         :integer          not null, primary key
#  name       :string
#  details    :text
#  used_time  :datetime
#  ticket_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :benefit do
    sequence(:name) { |n| "特典#{('A'.ord + n).chr}" }
    details { "チケット用の#{name}" }
    used_time { nil }
    association :ticket
  end
end
