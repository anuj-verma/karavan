class VehicleDetail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :from,                    type: String
  field :to,                      type: String
  field :estimated_distance,      type: Integer
  field :price_per_km,            type: Float
  field :price_per_day,           type: Integer
  field :penalty_per_km,          type: Float
  field :penalty_per_day,         type: Integer
  field :km_cap_per_day,          type: Integer
  field :package_type,            type: String

  embedded_in :vehicle
end
