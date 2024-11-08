FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph(sentence_count: 10) }
    user { nil }
    post { nil }
  end
end
