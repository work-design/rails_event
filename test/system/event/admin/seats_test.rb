require "application_system_test_case"

class SeatsTest < ApplicationSystemTestCase
  setup do
    @event_admin_seat = event_admin_seats(:one)
  end

  test "visiting the index" do
    visit event_admin_seats_url
    assert_selector "h1", text: "Seats"
  end

  test "creating a Seat" do
    visit event_admin_seats_url
    click_on "New Seat"

    fill_in "Max members", with: @event_admin_seat.max_members
    fill_in "Min members", with: @event_admin_seat.min_members
    fill_in "Name", with: @event_admin_seat.name
    click_on "Create Seat"

    assert_text "Seat was successfully created"
    click_on "Back"
  end

  test "updating a Seat" do
    visit event_admin_seats_url
    click_on "Edit", match: :first

    fill_in "Max members", with: @event_admin_seat.max_members
    fill_in "Min members", with: @event_admin_seat.min_members
    fill_in "Name", with: @event_admin_seat.name
    click_on "Update Seat"

    assert_text "Seat was successfully updated"
    click_on "Back"
  end

  test "destroying a Seat" do
    visit event_admin_seats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Seat was successfully destroyed"
  end
end
