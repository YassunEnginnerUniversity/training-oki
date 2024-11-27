# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph(sentence_count: 10)[0...120] }

    trait :post_over_content do
      content { Faker::Lorem.characters(number: 121) }
    end
  end
end
