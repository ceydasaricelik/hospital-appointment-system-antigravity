FactoryBot.define do
  factory :department do
    name { Faker::Company.profession }
    description { Faker::Lorem.sentence }
  end
end
