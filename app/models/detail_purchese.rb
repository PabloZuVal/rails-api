class DetailPurchese
  include Mongoid::Document
  include Mongoid::Timestamps
  field :quantity, type: Integer
  field :subtotal, type: Integer
end
