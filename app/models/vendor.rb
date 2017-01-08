class Vendor
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name,      type: String
  field :email,     type: String
  field :mobile,    type: String

end
