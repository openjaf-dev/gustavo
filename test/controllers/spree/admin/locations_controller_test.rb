require 'test_helper'

class Spree::Admin::LocationsControllerTest < ActionController::TestCase
  setup do
    @spree_admin_location = spree_admin_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spree_admin_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spree_admin_location" do
    assert_difference('Spree::Admin::Location.count') do
      post :create, spree_admin_location: { address: @spree_admin_location.address, city: @spree_admin_location.city, country: @spree_admin_location.country, distric: @spree_admin_location.distric, enabled: @spree_admin_location.enabled, lat: @spree_admin_location.lat, lng: @spree_admin_location.lng, location_name: @spree_admin_location.location_name, phone_number: @spree_admin_location.phone_number, postcode: @spree_admin_location.postcode, reference: @spree_admin_location.reference }
    end

    assert_redirected_to spree_admin_location_path(assigns(:spree_admin_location))
  end

  test "should show spree_admin_location" do
    get :show, id: @spree_admin_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spree_admin_location
    assert_response :success
  end

  test "should update spree_admin_location" do
    patch :update, id: @spree_admin_location, spree_admin_location: { address: @spree_admin_location.address, city: @spree_admin_location.city, country: @spree_admin_location.country, distric: @spree_admin_location.distric, enabled: @spree_admin_location.enabled, lat: @spree_admin_location.lat, lng: @spree_admin_location.lng, location_name: @spree_admin_location.location_name, phone_number: @spree_admin_location.phone_number, postcode: @spree_admin_location.postcode, reference: @spree_admin_location.reference }
    assert_redirected_to spree_admin_location_path(assigns(:spree_admin_location))
  end

  test "should destroy spree_admin_location" do
    assert_difference('Spree::Admin::Location.count', -1) do
      delete :destroy, id: @spree_admin_location
    end

    assert_redirected_to spree_admin_locations_path
  end
end
