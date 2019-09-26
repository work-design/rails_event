require "application_system_test_case"

class CrowdMembersTest < ApplicationSystemTestCase
  setup do
    @event_admin_crowd_member = event_admin_crowd_members(:one)
  end

  test "visiting the index" do
    visit event_admin_crowd_members_url
    assert_selector "h1", text: "Crowd Members"
  end

  test "creating a Crowd member" do
    visit event_admin_crowd_members_url
    click_on "New Crowd Member"

    click_on "Create Crowd member"

    assert_text "Crowd member was successfully created"
    click_on "Back"
  end

  test "updating a Crowd member" do
    visit event_admin_crowd_members_url
    click_on "Edit", match: :first

    click_on "Update Crowd member"

    assert_text "Crowd member was successfully updated"
    click_on "Back"
  end

  test "destroying a Crowd member" do
    visit event_admin_crowd_members_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Crowd member was successfully destroyed"
  end
end
