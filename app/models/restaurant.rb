class Restaurant < ApplicationRecord
  DEFAULT_TIME_SLOT = 30
  DEFAULT_MAX_RESERVED_PERIOD = 24

  has_many :tables

  def excluded_hours
    excluded_hours_string.split(',').map(&:to_i)
  end
end
