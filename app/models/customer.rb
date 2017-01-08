class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title,         type: String
  field :first_name,    type: String
  field :middle_name,   type: String
  field :last_name,     type: String
  field :mobile,        type: String
  field :birth_date,    type: Date
  field :email,         type: String
  field :address,       type: String
  field :gender,        type: String

  has_many :bookings

end
