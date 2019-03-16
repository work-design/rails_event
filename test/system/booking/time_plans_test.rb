require "application_system_test_case"

class TimePlansTest < ApplicationSystemTestCase
  setup do
    @booking_time_plan = booking_time_plans(:one)
  end

  test "visiting the index" do
    visit booking_time_plans_url
    assert_selector "h1", text: "Time Plans"
  end

  test "creating a Time plan" do
    visit booking_time_plans_url
    click_on "New Time Plan"

    fill_in "Repeat days", with: @booking_time_plan.repeat_days
    fill_in "Repeat type", with: @booking_time_plan.repeat_type
    fill_in "Room", with: @booking_time_plan.room_id
    fill_in "Time item", with: @booking_time_plan.time_item_id
    fill_in "Time list", with: @booking_time_plan.time_list_id
    click_on "Create Time plan"

    assert_text "Time plan was successfully created"
    click_on "Back"
  end

  test "updating a Time plan" do
    visit booking_time_plans_url
    click_on "Edit", match: :first

    fill_in "Repeat days", with: @booking_time_plan.repeat_days
    fill_in "Repeat type", with: @booking_time_plan.repeat_type
    fill_in "Room", with: @booking_time_plan.room_id
    fill_in "Time item", with: @booking_time_plan.time_item_id
    fill_in "Time list", with: @booking_time_plan.time_list_id
    click_on "Update Time plan"

    assert_text "Time plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Time plan" do
    visit booking_time_plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time plan was successfully destroyed"
  end
end
