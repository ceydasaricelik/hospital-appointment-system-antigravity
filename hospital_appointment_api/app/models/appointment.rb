class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  belongs_to :department

  validates :scheduled_at, presence: true
  validates :status, presence: true, inclusion: { in: %w[scheduled canceled completed] }
end
