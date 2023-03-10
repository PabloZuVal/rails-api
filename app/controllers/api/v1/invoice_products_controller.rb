class Api::V1::InvoiceProductsController < ApplicationController
  before_action :set_invoice_product, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]


  # GET /invoice_products or /invoice_products.json
  def index
    @invoice_products = InvoiceProduct.all
    return render json: { msj: "Invoice product list empty" }, status: :unprocessable_entity unless @invoice_products

    return render json: @invoice_products, status: :ok
  end

  # GET /invoice_products/1 or /invoice_products/1.json
  def show
  end

  # GET /invoice_products/new
  def new
    @invoice_product = InvoiceProduct.new
  end

  # GET /invoice_products/1/edit
  def edit
  end

  # POST /invoice_products or /invoice_products.json
  def create
    # @invoice_product = InvoiceProduct.new(invoice_product_params)

    @invoice = Invoice.find(params[:invoice_id])
    return render json: { msj: "Invoice not found" }, status: :unprocessable_entity unless @invoice

    products = []
    details = []
    total_purchase = 0

    params[:product_ids].each do |product|
      #Find product
      @product = Product.find(product[:id_product])
      return render json: { msj: "Product not found" }, status: :unprocessable_entity unless @product
      #Check stock
      return render json: { msj: "Product out of stock" }, status: :unprocessable_entity if @product.stock < product[:quantity]
      
      @product.stock = @product.stock - product[:quantity]

      total_purchase += @product.price * product[:quantity]
      products << @product

      details << { product: @product, quantity: product[:quantity] }
    end
    
    # #Upadate stock
    # products.each do |product|
    #   product.stock -= product.stock - product[:quantity]
    #   product.save
    # end

    params[:product_ids].each do |product|
      product_search = Product.where(:id => product[:id_product]).first
      return {error: "Product not found"} unless product_search.present?

      @invoice_product = InvoiceProduct.new(:details => params[:details], :total_price => 1234, total_purchase: 1234, :invoice_id => params[:invoice_id], :product_id => product_search[:_id])
      return render json: { msj: "InvoiceProduct not created", error: @invoice_product.errors }, status: :unprocessable_entity unless @invoice_product.save
            
    end


    render json: {msj: "invoice product created !"}, status: :created


  end

  # =============================================================================================================================
  
  def self.create_invoice(params)
    @user = User.find_by(id: params[:id])
    return '{"status":404, "message":"User not found"}' unless @user.present?
    products = []
    details = []
    @total_purchase = 0
    params[:products].each do |product|
      product_search = Product.where(:id => product[:id]).first
      return {error: "Product not found"} unless product_search.present?
      return {error: 'The product ' +  product_search[:name]  + " dont have stock"} if product_search[:stock] < product[:quantity]
      product_search[:stock] = product_search[:stock] - product[:quantity]
      @total_purchase = @total_purchase + (product_search[:price] * product[:quantity])
      products << product_search
    end

    # Actualizar stock
    # products.each do |product|
    #   return {error: "Error in the products", error: product.errors} unless product.save
    # end

    @invoice = Invoice.new(:method_pay_id => params[:method_pay_id], :date => params[:date_purchase], :user_id => @user)
    return '{"status":404, "message":"Invoice not created"}' unless @invoice.save
   
    # @details = Detail.new(:comment => params[:comment], date_purchase: params[:date_purchase], :invoice_id => @invoice, :price_total => params[:price_total], :product => products)
    # return {error:'Detail not created', error: @details.errors} unless @details.save
    params[:products].each do |product|
      product_search = Product.where(:id => product[:id]).first
      return {error: "Product not found"} unless product_search.present?
      @price_total_product = product_search[:price] * product[:quantity]
      details << Detail.new(:comment => params[:comment], date_purchase: params[:date_purchase], :invoice_id => @invoice, :price_total_purchase => @total_purchase, :price_total_product => @price_total_product ,:product => product_search, :quantity => product[:quantity], :name => product_search[:name] )
    end
    details.each do |detail|
      return {error: "Error in the details", error: detail.errors} unless detail.save
    end
    
    return details
  end

  # PATCH/PUT /invoice_products/1 or /invoice_products/1.json
  def update

  end

  # DELETE /invoice_products/1 or /invoice_products/1.json
  # def destroy
  #   @invoice_product.destroy

  #   respond_to do |format|
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_product
      @invoice_product = InvoiceProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_product_params
      params.permit(:details, :invoice_id, product_ids: [:id_product, :quantity])
    end
end
