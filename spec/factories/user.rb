FactoryBot.define do
  factory :user do
    name                  { 'Yamamoto' }
    email                 { 'yamamoto@test.com' }
    password              { 'yamamoto@test.com' }
    password_confirmation { 'yamamoto@test.com' }
    prefecture_id         { 1 }
    municipality          { '長岡市' }
  end
end