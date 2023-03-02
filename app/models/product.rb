class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :category_id, type: String
  field :name, type: String
  field :description, type: String
  field :stock, type: Integer
  field :price, type: Integer
  belongs_to :invoice
end
