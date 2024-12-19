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
    association :from_user, factory: :user
    association :to_user, factory: :user
    association :ticket_view
  end
end
