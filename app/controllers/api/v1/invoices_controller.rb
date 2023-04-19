class Api::V1::InvoicesController < ApplicationController
  before_action :invoice_params, only: %i[create show edit update destroy ]
  before_action :set_default_response_format
  skip_before_action :verify_authenticity_token, only: [:create]

  
  def create

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

