require 'test_helper'

class HomeControllerTest < ActiveSupport::TestCase
 
  def test_distance_response
    get(:distance, { 'address' => 'Budapest, Kapisztrán tér 2-4, 1014' })
    assert_response :success  
    # assert_routing('/home/1123%20Budapest,%20Alkotás%20utca%2050', 
    #   :controller => 'home', 
    #   :action => 'distance'
    # )
  end

  def test_distance_empty_address
    # TODO: 
  end

  def test_distance_wrong_address
    # TODO: can't geocode
  end

  def test_distance_same_address
    # TODO: result is 0.0
  end
end
