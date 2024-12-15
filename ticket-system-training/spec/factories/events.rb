# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  details    :text
#  date       :date
#  venue      :string
#  open_time  :time
#  start_time :time
#  end_time   :time
#  notes      :text
#  show_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :event do
    name { "MyString" }
    details { "MyText" }
    date { "2024-12-14" }
    venue { "MyString" }
    open_time { "2024-12-14 12:29:07" }
    start_time { "2024-12-14 12:29:07" }
    end_time { "2024-12-14 12:29:07" }
    notes { "MyText" }
    show { nil }
  end
end
