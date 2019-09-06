require 'test_helper'

class Event::TimePlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_time_plan = create booking_time_plans
  end

  test 'index ok' do
    get booking_time_plans_url
    assert_response :success
  end

  test 'new ok' do
    get new_booking_time_plan_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TimePlan.count') do
      post booking_time_plans_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to booking_time_plan_url(TimePlan.last)
  end

  test 'show ok' do
    get booking_time_plan_url(@booking_time_plan)
    assert_response :success
  end

  test 'edit ok' do
    get edit_booking_time_plan_url(@booking_time_plan)
    assert_response :success
  end

  test 'update ok' do
    patch booking_time_plan_url(@booking_time_plan), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to booking_time_plan_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('TimePlan.count', -1) do
      delete booking_time_plan_url(@booking_time_plan)
    end

    assert_redirected_to booking_time_plans_url
  end
end
