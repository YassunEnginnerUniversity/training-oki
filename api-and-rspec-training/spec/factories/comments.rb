# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph(sentence_count: 10) }
    user { nil }
    post { nil }

    trait :comment_over_content do
      content { Faker::Lorem.characters(number: 256) }
    end
  end
end
