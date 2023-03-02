# class Api::V1::InvoicesController < ApplicationController
#   before_action :set_detail_purchese, only: %i[ show edit update destroy ]
#   skip_before_action :verify_authenticity_token, only: [:create]

#   def new
#     @invoice = Invoice.new
#     @products = Product.all
#     @purchases = Purchase.all
#   end

#   # GET /detail_purcheses or /detail_purcheses.json
#   def index
#     @detail_purcheses = Invoice.all
#   end

#   # GET /detail_purcheses/1 or /detail_purcheses/1.json
#   def show
#   end

#   def create
#     # @detail_purchese = Invoice.new(invoice_params)
#     print "parametros!!!!!!!!"
#     print params[:products]

#     # response = Product.saveIvoice(params);
#     # return render json: response

#     # =============================

#     @invoice = Invoice.new(invoice_params)
#     return render json: {error: "Purchase could not be created"}, status: :unprocessable_entity unless @invoice.save
    
#     @purchase.invoices << @invoice

#     params[:product_ids].each do |product_id|
#       product = Product.find(product_id)
#       product.invoice = @invoice
#       product.save
#     end

#     return render json: { status: 'success', message: 'Invoice created successfully', invoice: @invoice }
#     # return render json: @invoice, status: :created
#     # =============================

#     # # return render json: {error: "Purchase could not be created"}, status: :unprocessable_entity unless @detail_purchese.save
    
#     # return render json: @detail_purchese, status: :created
#     # return render json: params, status: :created


#     # @products.each do |product|
#     #   product.save
#     # end
#     #params[:products].each do |product|
#       #product_list = Product.where(:id => product[:id], :quantity.gt => product[:quantity]).first
#       #product_list.quantity = product_list.quantity - product[:quantity]
#       #product_list.save
#     #end
#     # invoice = Invoice.create(:name => params[:name], :direction => params[:direction], :file => params[:file],:products => @products)
    
#     # return render json: invoice if invoice.save

#   end


#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_detail_purchese
#       @detail_purchese = Invoice.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def invoice_params
#       params.require(:invoice).permit(:name, :direction)
#     end
# end

class Api::V1::InvoicesController < ApplicationController
  before_action :set_detail_purchese, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def create
    @invoice = Invoice.new(invoice_params)
    @purchase = Purchase.find(params[:purchase_id])

    if @invoice.save
      @purchase.invoices << @invoice

      params[:product_ids].each do |product_id|
        product = Product.find(product_id)
        product.invoice = @invoice
        product.save
      end

      render json: { status: 'success', message: 'Invoice created successfully', invoice: @invoice }
    else
      render json: { status: 'error', message: 'Failed to create invoice', errors: @invoice.errors.full_messages }
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :direction)
  end
end

