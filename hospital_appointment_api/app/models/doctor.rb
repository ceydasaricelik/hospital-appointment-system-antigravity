class Doctor < ApplicationRecord
  belongs_to :user
  belongs_to :department
  has_many :appointments, dependent: :destroy

  validates :first_name, :last_name, :specialization, presence: true
end
