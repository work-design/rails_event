require "application_system_test_case"

class TimeListsTest < ApplicationSystemTestCase
  setup do
    @booking_admin_time_list = booking_admin_time_lists(:one)
  end

  test "visiting the index" do
    visit booking_admin_time_lists_url
    assert_selector "h1", text: "Time Lists"
  end

  test "creating a Time list" do
    visit booking_admin_time_lists_url
    click_on "New Time List"

    fill_in "Code", with: @booking_admin_time_list.code
    fill_in "Name", with: @booking_admin_time_list.name
    click_on "Create Time list"

    assert_text "Time list was successfully created"
    click_on "Back"
  end

  test "updating a Time list" do
    visit booking_admin_time_lists_url
    click_on "Edit", match: :first

    fill_in "Code", with: @booking_admin_time_list.code
    fill_in "Name", with: @booking_admin_time_list.name
    click_on "Update Time list"

    assert_text "Time list was successfully updated"
    click_on "Back"
  end

  test "destroying a Time list" do
    visit booking_admin_time_lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time list was successfully destroyed"
  end
end
