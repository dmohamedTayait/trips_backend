##
# Represents information about a Users(NemID, AD).
#
class TripLocation < ApplicationRecord
    belongs_to :trip
  
    acts_as_api
    api_accessible :basic do |template|
      template.add :location
      template.add 'start_time', as: :time
    end
end
