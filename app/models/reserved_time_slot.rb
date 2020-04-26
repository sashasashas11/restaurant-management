class ReservedTimeSlot < ApplicationRecord
  belongs_to :user
  belongs_to :table
  belongs_to :reservation

  scope :current, -> { where('time >= ?', Time.zone.now) }

  def print_time
    time.strftime('%H:%M')
  end
end
