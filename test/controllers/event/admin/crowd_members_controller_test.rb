require 'test_helper'

class Event::Admin::CrowdMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_admin_crowd_member = create event_admin_crowd_members
  end

  test 'index ok' do
    get admin_crowd_members_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_crowd_member_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('CrowdMember.count') do
      post admin_crowd_members_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to event_admin_crowd_member_url(CrowdMember.last)
  end

  test 'show ok' do
    get admin_crowd_member_url(@event_admin_crowd_member)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_crowd_member_url(@event_admin_crowd_member)
    assert_response :success
  end

  test 'update ok' do
    patch admin_crowd_member_url(@event_admin_crowd_member), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to event_admin_crowd_member_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('CrowdMember.count', -1) do
      delete admin_crowd_member_url(@event_admin_crowd_member)
    end

    assert_redirected_to admin_crowd_members_url
  end
end
