# == Schema Information
#
# Table name: seats
#
#  id          :integer          not null, primary key
#  seat_area   :string
#  seat_number :integer
#  ticket_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :seat do
    sequence(:seat_area) { |n| "エリア#{('A'.ord + n % 5).chr}" }
    seat_number { rand(100..500) }
    association :ticket
  end
end
