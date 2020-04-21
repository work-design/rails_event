require "application_system_test_case"

class PlaceTaxonsTest < ApplicationSystemTestCase
  setup do
    @event_admin_place_taxon = event_admin_place_taxons(:one)
  end

  test "visiting the index" do
    visit event_admin_place_taxons_url
    assert_selector "h1", text: "Place Taxons"
  end

  test "creating a Place taxon" do
    visit event_admin_place_taxons_url
    click_on "New Place Taxon"

    fill_in "Name", with: @event_admin_place_taxon.name
    fill_in "Places count", with: @event_admin_place_taxon.places_count
    fill_in "Position", with: @event_admin_place_taxon.position
    click_on "Create Place taxon"

    assert_text "Place taxon was successfully created"
    click_on "Back"
  end

  test "updating a Place taxon" do
    visit event_admin_place_taxons_url
    click_on "Edit", match: :first

    fill_in "Name", with: @event_admin_place_taxon.name
    fill_in "Places count", with: @event_admin_place_taxon.places_count
    fill_in "Position", with: @event_admin_place_taxon.position
    click_on "Update Place taxon"

    assert_text "Place taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Place taxon" do
    visit event_admin_place_taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Place taxon was successfully destroyed"
  end
end
