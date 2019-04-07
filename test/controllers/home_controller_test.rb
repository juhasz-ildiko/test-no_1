require 'test_helper'

class HomeControllerTest < ActiveSupport::TestCase
 
  def test_distance_from_response

    assert_routing('/home/1123%20Budapest,%20Alkotás%20utca%2050', 
      :controller => 'home', 
      :action => 'distance', 
      :address => '1088 Budapest, Múzeum krt. 14-16'
    )
  end
end
