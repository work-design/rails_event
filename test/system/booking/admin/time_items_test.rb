require "application_system_test_case"

class TimeItemsTest < ApplicationSystemTestCase
  setup do
    @booking_admin_time_item = booking_admin_time_items(:one)
  end

  test "visiting the index" do
    visit booking_admin_time_items_url
    assert_selector "h1", text: "Time Items"
  end

  test "creating a Time item" do
    visit booking_admin_time_items_url
    click_on "New Time Item"

    fill_in "Finish at", with: @booking_admin_time_item.finish_at
    fill_in "Position", with: @booking_admin_time_item.position
    fill_in "Start at", with: @booking_admin_time_item.start_at
    click_on "Create Time item"

    assert_text "Time item was successfully created"
    click_on "Back"
  end

  test "updating a Time item" do
    visit booking_admin_time_items_url
    click_on "Edit", match: :first

    fill_in "Finish at", with: @booking_admin_time_item.finish_at
    fill_in "Position", with: @booking_admin_time_item.position
    fill_in "Start at", with: @booking_admin_time_item.start_at
    click_on "Update Time item"

    assert_text "Time item was successfully updated"
    click_on "Back"
  end

  test "destroying a Time item" do
    visit booking_admin_time_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time item was successfully destroyed"
  end
end
