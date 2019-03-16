require 'test_helper'

class Booking::Admin::TimeItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_admin_time_item = create booking_admin_time_items
  end

  test 'index ok' do
    get admin_time_items_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_time_item_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TimeItem.count') do
      post admin_time_items_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to booking_admin_time_item_url(TimeItem.last)
  end

  test 'show ok' do
    get admin_time_item_url(@booking_admin_time_item)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_time_item_url(@booking_admin_time_item)
    assert_response :success
  end

  test 'update ok' do
    patch admin_time_item_url(@booking_admin_time_item), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to booking_admin_time_item_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('TimeItem.count', -1) do
      delete admin_time_item_url(@booking_admin_time_item)
    end

    assert_redirected_to admin_time_items_url
  end
end
