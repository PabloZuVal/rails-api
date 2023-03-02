class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :direction, type: String
  field :phone, type: String
  field :credit_card_id, type: String
  has_many :credit_card
end
