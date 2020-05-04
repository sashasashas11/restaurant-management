require 'test_helper'

module Reservations
  class AvailableSlotsTest < ActiveSupport::TestCase
    setup do
      @service = ::Reservations::AvailableSlots
      @table = tables(:one)
      @restaurant = restaurants(:one)

      Time.zone = 'UTC'
      travel_to Time.zone.parse('26/04/2020 09:00')
    end

    teardown do
      travel_back
    end

    def test_number_of_slots_for_24_hours
      result = service.call(table: table)

      assert_equal 48, result.count
    end

    def test_number_of_slots_for_2_hours
      restaurant.update!(max_reserved_period: 2)

      result = service.call(table: table)

      assert_equal 4, result.count
    end

    def test_slot_step_60_minutes
      restaurant.update!(slot_step: 60)

      result = service.call(table: table)

      assert_equal 24, result.count
    end

    # work from 10:00 to 02:00. Lunch 13:00-14:00
    def test_excluded_hours
      work_slots = %w(10:00 10:30 11:00 11:30 12:00 12:30 14:00 14:30 15:00 15:30 16:00 16:30 17:00 17:30 18:00 18:30
                      19:00 19:30 20:00 20:30 21:00 21:30 22:00 22:30 23:00 23:30 00:00 00:30 01:00 01:30)
      restaurant.update!(excluded_hours: [2,3,4,5,6,7,8,9,13])

      result = service.call(table: table)

      assert_equal 30, result.count
      assert_equal work_slots, result.map { |time| time.strftime('%H:%M') }
    end

    private

    attr_reader :service, :table, :restaurant
  end
end
