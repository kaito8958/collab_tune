FactoryBot.define do
  factory :user do
    nickname      { Faker::Name.first_name }
    email         { Faker::Internet.unique.email }
    password      { 'password123' }
    password_confirmation { password }
  end
end
