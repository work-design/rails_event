require 'test_helper'

class Booking::Admin::TimetablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_admin_timetable = create booking_admin_timetables
  end

  test 'index ok' do
    get admin_timetables_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_timetable_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Timetable.count') do
      post admin_timetables_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to booking_admin_timetable_url(Timetable.last)
  end

  test 'show ok' do
    get admin_timetable_url(@booking_admin_timetable)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_timetable_url(@booking_admin_timetable)
    assert_response :success
  end

  test 'update ok' do
    patch admin_timetable_url(@booking_admin_timetable), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to booking_admin_timetable_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Timetable.count', -1) do
      delete admin_timetable_url(@booking_admin_timetable)
    end

    assert_redirected_to admin_timetables_url
  end
end
