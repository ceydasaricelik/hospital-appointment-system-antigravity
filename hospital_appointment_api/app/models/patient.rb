class Patient < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy

  validates :first_name, :last_name, :date_of_birth, presence: true
end
