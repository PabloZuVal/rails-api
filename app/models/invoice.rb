class Invoice
  include Mongoid::Document
  include Mongoid::Timestamps
  # field :products_ids, type: Array, default: []
  field :name, type: String
  field :direction, type: String
  has_many :invoice_products

  # def self.saveIvoice(params)
    
  #   params[:product].each do |product|
  #     product_list = Product.find_by(:id => product[:id], :quantity.gt => product[:quantity])
  #     return render json: {error: "Product out of stock"}, status: :unprocessable_entity if product_list.nil?

  #     product_list.quantity = product_list.quantity - product[:quantity]
  #     product_list.save #Updated stock
  #   end

  #   @invoice = Invoice.create(:name => params[:name], :direction => params[:direction],:products => @products)
  #   return render json: @invoice if @invoice.save

  #   # begin
  #   #   product = Product.find(params[:id])
  #   # rescue => exception
  #   #   return {"status":404,"messaje":"product not found"}
  #   # end
  #   # inventory = Inventory

    
  # end
end
