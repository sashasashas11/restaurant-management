module Reservations
  class AvailableSlots < ::Callable
    def initialize(table:)
      @table = table
    end

    def call
      available_slots
    end

    private

    attr_reader :table

    delegate :restaurant, to: :table
    delegate :slot_step, :max_reserved_period, :excluded_hours, to: :restaurant

    def available_slots
      slots = all_slots

      slots.select! { |slot| slot >= Time.current }
      slots.reject! { |slot| excluded_hours.include?(slot.hour) }
      slots
    end

    def all_slots
      start = Time.zone.now.beginning_of_hour

      slots_number.times.map do |i|
        start + (slot_step * 60 * i)
      end
    end

    def slots_number
      (max_reserved_period.hours / slot_step.minutes)
    end
  end
end
