class Department < ApplicationRecord
  has_many :doctors
  has_many :appointments

  validates :name, presence: true, uniqueness: true
end
