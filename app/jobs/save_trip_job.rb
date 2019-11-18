class SaveTripLocationJob < ApplicationJob

  def perform(trip_location) 
    create trip_location
  end 

  def create trip_location
    new_trip = Trip.new!(driver: current_driver,bus: current_bus, start_time: Time.now, start_location: params[:start_location])
    new_trip.trip_locations << TripLocation.new(location: params[:start_location], start_time: Time.now )
  end
end
