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
    name { "MyString" }
    start_datetime { "2024-12-14 12:28:57" }
    end_datetime { "2024-12-14 12:28:57" }
    details { "MyText" }
    organizer { nil }
    play_guide { nil }
  end
end
