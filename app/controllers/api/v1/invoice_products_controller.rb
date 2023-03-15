class Api::V1::InvoiceProductsController < ApplicationController
  before_action :set_invoice_product, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]
  include ResponseHelper
  # use TrustGem::AuthorizationCheck

  # GET /invoice_products or /invoice_products.json
  def index
    @invoice_products = InvoiceProduct.all
    return render json: { msj: "Invoice product list empty" }, status: :unprocessable_entity unless @invoice_products

    # return render json: @invoice_products, status: :ok
    return ok_render("invoice_products", @invoice_products)
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
    response = InvoiceProduct.create_invoice_product(params)
    
    if response.success
      return ok_render(response.message , response)
    else
      return not_found_render(response)
    end
    # return render json: resp, status: :ok
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
