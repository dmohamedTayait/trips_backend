##
# Represents information about a Bus Trips.
#
class Trip < ApplicationRecord
 
  belongs_to :driver
  belongs_to :bus

  has_many :trip_locations

  acts_as_paranoid
  
  acts_as_api
  api_accessible :basic do |template|
    template.add :id
    template.add 'bus.code', as: :bus_code
    template.add 'driver.name', as: :driver_name
    template.add :start_time
    template.add :end_time
    template.add :start_location
    template.add :end_location
    template.add :created_at
    template.add :trip_locations
  end
end
