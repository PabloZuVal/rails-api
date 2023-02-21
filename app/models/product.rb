class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :stock, type: Integer
  field :price, type: Integer
end
