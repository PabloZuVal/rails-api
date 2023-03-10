class Api::V1::InvoicesController < ApplicationController
  before_action :invoice_params, only: %i[create show edit update destroy ]
  before_action :set_default_response_format
  skip_before_action :verify_authenticity_token, only: [:create]

  
  def create
    # products = []

    # params[:product_ids].each do |product|
    #   #find product and verify if exist
    #   product_list = Product.find(:_id => product[:id_product])
    #   return render json: {error: "Product could not be finded"}, status: :unprocessable_entity if product_list.nil?
    #   #verify stock
    #   return render json: { error: "Product " + product_list[:name] +" out of stock"} if product_list[:stock] < product[:quantity]
    #   #Update stock
    #   product_list[:stock] = product_list[:stock] - product[:quantity]
    #   product_list.save

    #   #add product to list
    #   products << product_list
    # end


    # # create invoice and save products
    # @invoice = Invoice.new(:products_ids => params[:product_ids], :name => params[:name], :direction => params[:direction], :purchase_id => params[:purchase_id])
    # # return render json: {error: "Invoice could not be created"}, status: :unprocessable_entity unless @invoice.save


    # if @invoice.save
    #   render json: @invoice, status: :created
    # else
    #   render json: @invoice.errors, status: :unprocessable_entity
    # end

    # secction 2 =============================================================================
    # products = []
    # params[:product_ids].each do |product|
    #   # find product and verify if exist
    #   product_list = Product.find(:_id => product[:id_product])
    #   return render json: { error: "Product could not be found" }, status: :unprocessable_entity if product_list.nil?
    #   # verify stock
    #   return render json: { error: "Product " + product_list[:name] + " out of stock" } if product_list[:stock] < product[:quantity]
    #   # Update stock
    #   product_list[:stock] = product_list[:stock] - product[:quantity]
    #   # add product to list
    #   products << product_list
    #   product_list.save
    # end

    # # create invoice and save products
    # @invoice = Invoice.new(name: params[:name], direction: params[:direction], purchase_id: params[:purchase_id])
    
    # # products.each do |product|
    # #   @invoice[:products_ids] << product
    # # end
    
    # return render json: { error: "Invoice could not be created",error: @invoice.errors }, status: :unprocessable_entity unless @invoice.save

    # return render json: @invoice, status: :created

    # secction 3 =============================================================================

    @purchase = Purchase.find(params[:purchase_id])
    return render json: { error: "Purchase could not be found" }, status: :unprocessable_entity if @purchase.nil?

    @invoice = Invoice.new(:name => params[:name], :direction => params[:direction])
    return render json: { error: "Invoice could not be created" }, status: :unprocessable_entity unless @invoice.save

    return render json: @invoice, status: :created

  end

  def index
    @invoices = Invoice.all
    render json: @invoices
  end
  
  private
    def invoice_params
      params.permit(:format, :purchase_id, :name, :direction, product_ids: [:id_product, :quantity], :invoice => {})
    end
    
    def set_default_response_format
      request.format = :json
    end
end

