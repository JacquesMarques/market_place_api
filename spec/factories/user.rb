FactoryBot.define do
  factory :user do
    id {1}
    email { Faker::Internet.email }
    password_digest { BCrypt::Password.create('12345') }
  end
end