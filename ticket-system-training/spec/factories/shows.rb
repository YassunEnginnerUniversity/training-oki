# == Schema Information
#
# Table name: shows
#
#  id             :integer          not null, primary key
#  name           :string
#  start_datetime :datetime
#  end_datetime   :datetime
#  details        :text
#  organizer_id   :integer          not null
#  play_guide_id  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :show do
    sequence(:name) { |n| "興行#{('A'.ord + n - 1).chr}" }
    start_datetime { "2024-01-01 10:00:00" }
    end_datetime { "2024-07-31 10:00:00" }
    details { "#{name}の詳細" }
    association :organizer
  end
end
