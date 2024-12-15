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
    name { "MyString" }
    price { 1.5 }
    event { nil }
  end
end
