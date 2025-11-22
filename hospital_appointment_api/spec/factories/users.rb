FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password123" }
    role { "patient" }

    trait :patient do
      role { "patient" }
    end

    trait :doctor do
      role { "doctor" }
    end

    trait :admin do
      role { "admin" }
    end
  end
end
