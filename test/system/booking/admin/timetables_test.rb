require "application_system_test_case"

class TimetablesTest < ApplicationSystemTestCase
  setup do
    @booking_admin_timetable = booking_admin_timetables(:one)
  end

  test "visiting the index" do
    visit booking_admin_timetables_url
    assert_selector "h1", text: "Timetables"
  end

  test "creating a Timetable" do
    visit booking_admin_timetables_url
    click_on "New Timetable"

    fill_in "Finish at", with: @booking_admin_timetable.finish_at
    fill_in "Kind", with: @booking_admin_timetable.kind
    fill_in "Start at", with: @booking_admin_timetable.start_at
    click_on "Create Timetable"

    assert_text "Timetable was successfully created"
    click_on "Back"
  end

  test "updating a Timetable" do
    visit booking_admin_timetables_url
    click_on "Edit", match: :first

    fill_in "Finish at", with: @booking_admin_timetable.finish_at
    fill_in "Kind", with: @booking_admin_timetable.kind
    fill_in "Start at", with: @booking_admin_timetable.start_at
    click_on "Update Timetable"

    assert_text "Timetable was successfully updated"
    click_on "Back"
  end

  test "destroying a Timetable" do
    visit booking_admin_timetables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Timetable was successfully destroyed"
  end
end
