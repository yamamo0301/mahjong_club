FactoryBot.define do
  factory :rule do
    name { Faker::Lorem.characters(number:10) }
    tip_point { Faker::Number.between(from: 0, to: 99) }
    table_point { Faker::Number.between(from: 0, to: 99) }
    calculation_status { Faker::Number.between(from: 0, to: 3) }
  end
end