module DistanceCalculation
  extend ActiveSupport::Concern

  def distance_from_to(address_from, address_to)
    require 'geokit'

    address_from_geo = Geokit::Geocoders::GoogleGeocoder.geocode(address_from)
    raise "Can't geocode the given address: #{address_from}!" unless address_from_geo.success
    address_to_geo = Geokit::Geocoders::GoogleGeocoder.geocode(address_to)
    address_from_geo.distance_to(address_to_geo)
  end
end
