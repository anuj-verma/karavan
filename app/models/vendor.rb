class Vendor
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :vendor_name,        type: String
  field :short_name,  type: String
  field :email,       type: String
  field :mobile,      type: String
  field :logo,        type: String
  field :website,     type: String
  field :address,     type: String

  validates_presence_of :vendor_name, :short_name, :email, :mobile, :logo

  has_many :vehicles
  has_many :bookings
end
