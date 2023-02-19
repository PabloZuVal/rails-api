class CreditCard
  include Mongoid::Document
  include Mongoid::Timestamps
  field :number_card, type: String
  field :expiration_date, type: String
  field :security_code, type: String
  field :user_id, type: String
  belongs_to :user
end
