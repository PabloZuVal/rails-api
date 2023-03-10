class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  field :total, type: Integer
  belongs_to :user # user_id
  has_many :invoice # invoice_id
end
