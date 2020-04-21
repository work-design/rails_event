require 'test_helper'
class Event::Admin::PlaceTaxonsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @event_admin_place_taxon = create event_admin_place_taxons
  end

  test 'index ok' do
    get admin_place_taxons_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_place_taxon_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('PlaceTaxon.count') do
      post admin_place_taxons_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_place_taxon_url(@event_admin_place_taxon)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_place_taxon_url(@event_admin_place_taxon)
    assert_response :success
  end

  test 'update ok' do
    patch admin_place_taxon_url(@event_admin_place_taxon), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('PlaceTaxon.count', -1) do
      delete admin_place_taxon_url(@event_admin_place_taxon)
    end

    assert_response :success
  end

end
