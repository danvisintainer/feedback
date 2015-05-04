FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    password {Faker::Internet.password}
    avatar_url {Faker::Internet.url}
  end
end
