class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  field :total, type: Integer
  belongs_to :user
  has_many :invoice
end
