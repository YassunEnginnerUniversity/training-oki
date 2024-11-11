FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph(sentence_count: 10) }

    trait :post_over_content do
      content { Faker::Lorem.characters(number: 256) }
    end
  end
end
