class Restaurant < ApplicationRecord
  DEFAULT_TIME_SLOT = 30
  DEFAULT_MAX_RESERVED_PERIOD = 24
  serialize :excluded_hours, Array

  has_many :tables
end
