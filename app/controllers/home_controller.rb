# frozen_string_literal: true

# HomeController class for calculating distance between two address
# Usage in localhost:
#    http://localhost:3000/home/Budapest, Kapisztrán tér 2-4, 1014
# or 
#    http://localhost:3000/home/1088 Budapest, Múzeum krt. 14-16
class HomeController < ApplicationController
  include DistanceCalculation

  COMPANY_ADDRESS = '1123 Budapest, Alkotás utca 50'

  def distance
    @address_to = COMPANY_ADDRESS
    @address_from = permitted['address']
    @meter = distance_from_to(@address_from, @address_to)
  rescue => e
    render body: "\n\nSomething went wrong, we can't calculate the distance.\n\nError:\n#{e}"
  end

  private

  def permitted
    params.permit(:address)
  end  
end
