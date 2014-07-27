class Location < ActiveRecord::Base
  belongs_to :restaurant
  geocoded_by :address
  after_validation :geocode
end
