class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  field :total, type: Integer
  belongs_to :user # user_id
  has_many :invoice # invoice_id

  self.create_invoice(params)
    @invoice = Invoice.find(params[:invoice_id])
    return { msj: "Invoice not found", status: :unprocessable_entity }  unless @invoice
    
end
