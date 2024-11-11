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
