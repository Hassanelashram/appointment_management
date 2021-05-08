class Dentist < ApplicationRecord
  has_many :appointments
  DAY_START = "08:00"
  DAY_END = "18:00"
  LUNCH_START = "12:00"
  LUNCH_END = "13:00"
end
