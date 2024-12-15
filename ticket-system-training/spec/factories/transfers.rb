# == Schema Information
#
# Table name: transfers
#
#  id             :integer          not null, primary key
#  from_user_id   :integer
#  to_user_id     :integer
#  ticket_view_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :transfer do
    from_user_id { 1 }
    to_user_id { 1 }
    ticket_view { nil }
  end
end
