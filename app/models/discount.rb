class Discount
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :discount, type: Integer
  field :date_ini, type: Date
  field :date_end, type: Date
end
