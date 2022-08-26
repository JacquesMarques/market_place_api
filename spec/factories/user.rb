FactoryBot.define do
  factory :user do
    id {1}
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password }
  end
end