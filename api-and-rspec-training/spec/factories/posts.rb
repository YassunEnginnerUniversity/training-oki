FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph(sentence_count: 10) }
  end
end
