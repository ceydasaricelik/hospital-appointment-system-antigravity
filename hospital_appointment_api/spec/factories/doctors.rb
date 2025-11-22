FactoryBot.define do
  factory :doctor do
    user
    department
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    specialization { "General" }
  end
end
