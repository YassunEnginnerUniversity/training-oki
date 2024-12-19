# == Schema Information
#
# Table name: organizers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :organizer do
    sequence(:name) { |n| "興行主#{('A'.ord + n - 1).chr}" }
  end
end
