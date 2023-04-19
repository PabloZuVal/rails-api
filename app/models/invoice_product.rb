class InvoiceProduct
  include Mongoid::Document
  include Mongoid::Timestamps
  # field :quantity, type: Integer
  field :total_price, type: Integer
  field :total_purchase, type: Integer
  field :details, type: String
  belongs_to :invoice
  belongs_to :product

  def self.create_invoice_product(params)
    
    @invoice = Invoice.find(params[:invoice_id])
    return ApiResponse.new(false, "Invoice not found", :unprocessable_entity, []) unless @invoice
    # return { msj: "Invoice not found", status: :unprocessable_entity }  unless @invoice

    products = []
    details = []
    total_purchase = 0

    params[:product_ids].each do |product|
      textStock = ""
      #Find product
      @product = Product.find(product[:id_product])
      return ApiResponse.new(false, "Product not found", :unprocessable_entity,[]) if @product.nil?

      #Check stock
      textStock = "Product " + @product.name + " out of stock"
      return ApiResponse.new(false, textStock, :unprocessable_entity,"Current stock : " + @product.stock.to_s) if @product.stock < product[:quantity]

      # Create invoice product
      @invoice_product = InvoiceProduct.new(:details => params[:details], :total_price => 1234, total_purchase: 1234, :invoice_id => params[:invoice_id], :product_id => @product[:_id])
      return ApiResponse.new(false, "InvoiceProduct not created", @invoice_product.errors) unless @invoice_product.save

      # Update stock product
      if @product.stock.present?
        @product.stock = @product.stock - product[:quantity]
        @product.save
      end

      total_purchase += @product.price * product[:quantity]

      details << { product: @product, details: @invoice_product }

    end
    
    # params[:product_ids].each do |product|
    #   @product_search = Product.where(:id => product[:id_product]).first

    #   return ApiResponse.new(false, "Product not found", :unprocessable_entity, []) unless @product_search.present?
      
    #   @invoice_product = InvoiceProduct.new(:details => params[:details], :total_price => 1234, total_purchase: 1234, :invoice_id => params[:invoice_id], :product_id => @product_search[:_id])
    #   return ApiResponse.new(false, "InvoiceProduct not created", @invoice_product.errors) unless @invoice_product.save

    #   details << { product: @product_search, details: @invoice_product }
    # end

    return ApiResponse.new(true, "invoice product created !", false, details)
  end
end

class ApiResponse
  attr_reader :success, :message, :errors, :data
  
  def initialize(success, message, errors, data)
    @success = success
    @message = message
    @errors = errors
    @data = data
  end
end
