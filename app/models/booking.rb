class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  field :transaction_number,        type: String
  field :payment_type,              type: String
  field :status,                    type: String
  field :amount,                    type: Float
  field :issued_at,                 type: DateTime


  belongs_to :car
  belongs_to :customer
  belongs_to :vendor
end
