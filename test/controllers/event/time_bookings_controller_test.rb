require 'test_helper'

class Event::TimeBookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = create bookings
  end

  test 'index ok' do
    get bookings_url
    assert_response :success
  end

  test 'new ok' do
    get new_booking_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: { } }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test 'show ok' do
    get booking_url(@booking)
    assert_response :success
  end

  test 'edit ok' do
    get edit_booking_url(@booking)
    assert_response :success
  end

  test 'update ok' do
    patch booking_url(@booking), params: { booking: {} }
    assert_redirected_to booking_url(@booking)
  end

  test 'destroy ok' do
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
