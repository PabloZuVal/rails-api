class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]
  before_action :set_default_response_format
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
    return render json: { msj: "Product list empty" }, status: :unprocessable_entity unless @products

    return render json: @products, status: :ok
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    return render json: { msj: "Product not found" }, status: :unprocessable_entity unless @product
    
    return render json: @product, status: :ok
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  # def edit
  #   # edit product
  #   @product = Product.find(params[:id])
  #   return render json: { msj: "Product not found" }, status: :unprocessable_entity unless @product
      
  #   return render json: @product, status: :ok

  # end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    return render json: @product.errors, status: :unprocessable_entity unless @product.save

    return render json: @product, status: :created
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = Product.find(params[:id])
    return render json: { msj: "Product not found" }, status: :unprocessable_entity unless @product.update(product_params)

    return render json: @product, status: :ok
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      #format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.permit(:name, :description, :stock, :price,:category_id)
    end

    def set_default_response_format
      request.format = :json
    end
end
