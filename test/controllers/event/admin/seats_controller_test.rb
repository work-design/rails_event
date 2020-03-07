require 'test_helper'
class Event::Admin::SeatsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @event_admin_seat = create event_admin_seats
  end

  test 'index ok' do
    get admin_seats_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_seat_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Seat.count') do
      post admin_seats_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_seat_url(@event_admin_seat)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_seat_url(@event_admin_seat)
    assert_response :success
  end

  test 'update ok' do
    patch admin_seat_url(@event_admin_seat), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Seat.count', -1) do
      delete admin_seat_url(@event_admin_seat)
    end

    assert_response :success
  end

end
