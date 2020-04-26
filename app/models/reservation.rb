class Reservation < ApplicationRecord
  belongs_to :table
  belongs_to :user
  has_many :reserved_time_slots
end
