# == Schema Information
#
# Table name: ticket_types
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :ticket_type do
    sequence(:name) { |n| "券種#{('A'.ord + n - 1).chr}" }
    price { rand(8000..15000) }
    association :event
  end
end
