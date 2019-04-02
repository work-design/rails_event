require 'test_helper'

class Booking::TimeBookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_time_booking = create booking_time_bookings
  end

  test 'index ok' do
    get booking_time_bookings_url
    assert_response :success
  end

  test 'new ok' do
    get new_booking_time_booking_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TimeBooking.count') do
      post booking_time_bookings_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to booking_time_booking_url(TimeBooking.last)
  end

  test 'show ok' do
    get booking_time_booking_url(@booking_time_booking)
    assert_response :success
  end

  test 'edit ok' do
    get edit_booking_time_booking_url(@booking_time_booking)
    assert_response :success
  end

  test 'update ok' do
    patch booking_time_booking_url(@booking_time_booking), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to booking_time_booking_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('TimeBooking.count', -1) do
      delete booking_time_booking_url(@booking_time_booking)
    end

    assert_redirected_to booking_time_bookings_url
  end
end
