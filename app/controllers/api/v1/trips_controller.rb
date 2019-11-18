##
# Trips Controller: Crud Trips
#
class Api::V1::TripsController < Api::V1::ApiController
  #before_action :restrict_access, only: :create
  
  api! 'Get All trips by status'
  example '{
    "trip": {
        "id": 1,
        "bus_code": "abc123",
        "driver_name": "Tayseer",
        "start_time": "2019-11-05T19:19:41.117Z",
        "end_time": null,
        "start_location": "maskan",
        "end_location": null,
        "created_at": "2019-11-05T19:19:41.140Z",
        "trip_locations": [
          {
              "location": "maskan",
              "time": "2019-11-05T20:16:54.268Z"
          },
          {
              "location": "fifth settelment",
              "time": "2019-11-05T20:19:02.593Z"
          },
          {
              "location": "roxi",
              "time": "2019-11-18T12:43:03.045Z"
          },
          {
              "location": "abbaseya",
              "time": "2019-11-18T12:46:53.288Z"
          }
        ]
      }
    }'
  def index
    status = params[:status] || 0
    render_for_api :basic, json: current_driver.trips.where(status: status)
  end

  api! 'Create new trip.'
  def create
    current_bus = Bus.find(params[:bus_id])
    new_trip = Trip.create!(driver: current_driver,bus: current_bus, start_time: Time.now, start_location: params[:start_location])
    new_trip.trip_locations << TripLocation.new(location: params[:start_location], start_time: Time.now )
    render_for_api :basic, json: new_trip
  end

  api! 'Mark trip as completed.'
  def mark_completed
    current_trip.update(status: 1, end_time: Time.now, end_location: params[:end_location])
    current_trip.trip_locations << TripLocation.new(location: params[:end_location], start_time: Time.now )
    render_success
  end

  api! 'Delete user chat'
  def destroy
    Trip.find(params[:id]).delete
    render_success
  end
 
  private

  def current_trip
    return Trip.find(params[:trip_id])
  end
end
