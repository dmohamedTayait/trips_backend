##
# Trips Controller: Crud Trips
#
class Api::V1::TripLocationsController < Api::V1::ApiController

  api! 'Create new trip.'
  def create
    current_trip.trip_locations << TripLocation.new(location: params[:current_location], start_time: Time.now )
    render_success
  end
 
  private

  def current_trip
    return Trip.find(params[:trip_id])
  end
end
