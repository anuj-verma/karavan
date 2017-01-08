class Quotation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :from_city,           type: String
  field :to_city,             type: String
  field :start_date,           type: Date
  field :end_date,             type: Date
  field :max_people,          type: Integer


  def search_vehicles
    results = []
    vehicles = Vehicle.where(
      origin_city: self.from_city,
      :seating_capacity.gte => self.max_people,
      'vehicle_details.to': self.to_city,
      reserved: {
        '$not': {
          '$elemMatch': {
            from: {
              '$lte' => self.end_date
            },
            to: {
              '$gte' => self.start_date
            }
          }
        }
      }
    )
    vehicles.each do |vehicle|
      results << vehicle.vehicle_details.where(to: self.to_city).first.as_json(except: [:_id, :created_at, :updated_at])
        .merge!(vendor: vehicle.vendor.as_json(only: [:vendor_name, :short_name, :logo]))
    end
    results
  end
end
