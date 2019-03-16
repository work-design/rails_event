require 'test_helper'

class Booking::Admin::TimeListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_admin_time_list = create booking_admin_time_lists
  end

  test 'index ok' do
    get admin_time_lists_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_time_list_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TimeList.count') do
      post admin_time_lists_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to booking_admin_time_list_url(TimeList.last)
  end

  test 'show ok' do
    get admin_time_list_url(@booking_admin_time_list)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_time_list_url(@booking_admin_time_list)
    assert_response :success
  end

  test 'update ok' do
    patch admin_time_list_url(@booking_admin_time_list), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to booking_admin_time_list_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('TimeList.count', -1) do
      delete admin_time_list_url(@booking_admin_time_list)
    end

    assert_redirected_to admin_time_lists_url
  end
end
