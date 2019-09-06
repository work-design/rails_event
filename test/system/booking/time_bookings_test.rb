require "application_system_test_case"

class TimeBookingsTest < ApplicationSystemTestCase
  setup do
    @booking_time_booking = booking_time_bookings(:one)
  end

  test "visiting the index" do
    visit booking_time_bookings_url
    assert_selector "h1", text: "Time Bookings"
  end

  test "creating a Time booking" do
    visit booking_time_bookings_url
    click_on "New Time Booking"

    fill_in "Booking on", with: @booking_time_booking.booking_on
    fill_in "Place", with: @booking_time_booking.place_id
    fill_in "Time item", with: @booking_time_booking.time_item_id
    fill_in "Time list", with: @booking_time_booking.time_list_id
    click_on "Create Time booking"

    assert_text "Time booking was successfully created"
    click_on "Back"
  end

  test "updating a Time booking" do
    visit booking_time_bookings_url
    click_on "Edit", match: :first

    fill_in "Booking on", with: @booking_time_booking.booking_on
    fill_in "Place", with: @booking_time_booking.place_id
    fill_in "Time item", with: @booking_time_booking.time_item_id
    fill_in "Time list", with: @booking_time_booking.time_list_id
    click_on "Update Time booking"

    assert_text "Time booking was successfully updated"
    click_on "Back"
  end

  test "destroying a Time booking" do
    visit booking_time_bookings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time booking was successfully destroyed"
  end
end
