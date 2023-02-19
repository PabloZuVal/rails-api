json.extract! credit_card, :id, :number_card, :expiration_date, :security_code, :created_at, :updated_at
json.url credit_card_url(credit_card, format: :json)
