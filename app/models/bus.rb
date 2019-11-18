##
# Represents information about a Users(NemID, AD).
#
class Bus < ApplicationRecord

  has_many :trips

  validates_presence_of :code
  validates_uniqueness_of :code
end
