module Reservations
  class ValidTimeSlot < ::Callable
    def initialize(time_slot:, table:)
      @time_slot = time_slot
      @table = table
    end

    def call
      valid?
    end

    private

    attr_reader :time_slot, :table

    def valid?
      reserved_slots.exclude?(time_slot) && available_slots.include?(time_slot)
    end

    def available_slots
      Reservations::AvailableSlots.call(table: table)
    end

    def reserved_slots
      table.reserved_time_slots.current.map(&:time)
    end
  end
end
