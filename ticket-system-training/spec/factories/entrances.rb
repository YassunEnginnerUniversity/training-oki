# == Schema Information
#
# Table name: entrances
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :entrance do
    sequence(:name) { |n| "入場口#{('A'..'Z').to_a[n - 1]}" }
  end
end
