FactoryBot.define do
  factory :sport do
    name { FFaker::Lorem.word }
    victory_rule { %w[asc desc].sample }
  end
end
