require 'test_helper'

module Reservations
  class ValidTimeSlotTest < ActiveSupport::TestCase
    setup do
      @service = ::Reservations::ValidTimeSlot
      @table = tables(:one)
      @restaurant = restaurants(:one)

      Time.zone = 'UTC'
      travel_to Time.zone.parse('26/04/2020 09:00')
    end

    teardown do
      travel_back
    end

    def test_valid_slot
      result = service.call(table: table, time_slot: '10:30')

      assert_equal true, result
    end

    def test_not_work_time
      restaurant.update!(excluded_hours_string: '10')
      result = service.call(table: table, time_slot: '10:00')

      assert_equal false, result
    end

    def test_not_correct_step
      result = service.call(table: table, time_slot: '10:10')

      assert_equal false, result
    end

    def test_not_valid_time
      result = service.call(table: table, time_slot: 'not_valid_time')

      assert_equal false, result
    end

    def test_valid_time_object
      result = service.call(table: table, time_slot: Time.zone.parse('10:30'))

      assert_equal true, result
    end

    def test_yesterday
      result = service.call(table: table, time_slot: Time.zone.parse('25/04/2020 10:30'))

      assert_equal false, result
    end

    def test_future
      result = service.call(table: table, time_slot: Time.zone.parse('27/04/2020 09:30'))

      assert_equal false, result
    end

    def test_reserved_time
      result = service.call(table: table, time_slot: '12:00')

      assert_equal false, result
    end

    private

    attr_reader :service, :table, :restaurant
  end
end
