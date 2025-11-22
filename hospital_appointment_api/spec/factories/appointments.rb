FactoryBot.define do
  factory :appointment do
    patient
    doctor
    department
    scheduled_at { Faker::Time.forward(days: 5, period: :morning) }
    status { "scheduled" }
  end
end
