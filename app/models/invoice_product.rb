class InvoiceProduct
  include Mongoid::Document
  include Mongoid::Timestamps
  # field :quantity, type: Integer
  field :total_price, type: Integer
  field :total_purchase, type: Integer
  field :details, type: String
  belongs_to :invoice
  belongs_to :product
end
