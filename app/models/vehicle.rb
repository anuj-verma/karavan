class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :make,                    type: String
  field :model,                   type: String
  field :submodel,                type: String
  field :registration_number,     type: String
  field :vehicle_type,            type: String
  field :seating_capacity,        type: Integer
  field :origin_city,             type: String
  
  # Booking Related Fields
  field :reserved,                type: Array, default: []

  validates_uniqueness_of :registration_number

  belongs_to :vendor
  has_many :bookings
  embeds_many :vehicle_details
end
