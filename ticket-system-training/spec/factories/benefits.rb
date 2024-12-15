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
    name { "MyString" }
    details { "MyText" }
    used_time { "2024-12-14 12:30:47" }
    ticket { nil }
  end
end
