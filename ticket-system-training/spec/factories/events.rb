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
    sequence(:name) { |n| "公演#{('A'.ord + n - 1).chr('UTF-8')}" }
    details { "#{name}の詳細" }
    date { "2024-01-01" }
    sequence(:venue) { |n| "会場#{('A'.ord + n - 1).chr('UTF-8')}" }
    open_time { "16:30" }
    start_time { "17:30" }
    end_time { "20:30" }
    association :show
  end
end

