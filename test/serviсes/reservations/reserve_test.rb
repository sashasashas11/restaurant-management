require 'test_helper'

module Reservations
  class ReserveTest < ActiveSupport::TestCase
    setup do
      @service = ::Reservations::Reserve
      @user = users(:one)
      @table = tables(:one)

      Time.zone = 'UTC'
      travel_to Time.zone.parse('26/04/2020 09:00')
    end

    teardown do
      travel_back
    end

    def test_success_reserve
      reserved_time = Time.zone.parse('10:30')

      result = service.call(time_slots: [reserved_time], table: table, user: user)

      assert_equal 1, result.reserved_time_slots.count
      assert_equal reserved_time, result.reserved_time_slots.first.time
      assert_equal user, result.user
      assert_equal table, result.table
      assert_equal user, result.reserved_time_slots.first.user
      assert_equal table, result.reserved_time_slots.first.table
    end

    def test_two_slots
      first_time = Time.zone.parse('10:30')
      second_time = Time.zone.parse('11:00')

      result = service.call(time_slots: [first_time, second_time], table: table, user: user)

      assert_equal first_time, result.reserved_time_slots.first.time
      assert_equal second_time, result.reserved_time_slots.last.time
    end

    def test_not_valid_slot
      first_time = Time.zone.parse('11:30')
      second_time = Time.zone.parse('12:00')

      assert_raises InvalidTimeSlot do
        service.call(time_slots: [first_time, second_time], table: table, user: user)
      end
    end

    private

    attr_reader :service, :user, :table
  end
end
