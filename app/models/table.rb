class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reserved_time_slots
end
