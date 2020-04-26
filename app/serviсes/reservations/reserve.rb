module Reservations
  class Reserve < ::Callable
    def initialize(time_slots:, table:, user:)
      @time_slots = time_slots
      @table = table
      @user = user
    end

    def call
      raise InvalidTimeSlot unless valid_time_slots?

      create_reservation.tap(&method(:create_time_slots))
    end

    private

    attr_reader :time_slots, :table, :user

    def create_time_slots(reservation)
      time_slots.each do |time|
        ReservedTimeSlot.create!(
          table: table,
          user: user,
          reservation: reservation,
          time: time
        )
      end
    end

    def create_reservation
      Reservation.create!(table: table, user: user)
    end

    def valid_time_slots?
      time_slots.all? do |slot|
        Reservations::ValidTimeSlot.call(table: table, time_slot: slot)
      end
    end
  end
end
