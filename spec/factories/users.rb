FactoryBot.define do
  factory :user do
    name { 'Test User' }
    nickname { 'Nick Test' }
    email { 'email@test.com' }
    password { '123456' }
  end
end
