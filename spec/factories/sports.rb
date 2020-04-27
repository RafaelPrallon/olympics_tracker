FactoryBot.define do
  factory :sport do
    name { Faker::Lorem.word }
    victory_rule { %w[asc desc].sample }
    valid_attempts {Faker::Number.within(range: 0..255)}
  end
end
