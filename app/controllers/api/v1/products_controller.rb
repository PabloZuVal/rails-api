class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /products or /products.json
  def index
    @products = Product.all
    return render json: { msj: "Product list empty" }, status: :unprocessable_entity unless @products

    return render json: @products, status: :ok
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    return render json: @product.errors, status: :unprocessable_entity unless @product.save

    return render json: @product, status: :created
  end

  # PATCH/PUT /products/1 or /products/1.json
  # def update
  #   respond_to do |format|
  #     if @product.update(product_params)
  #       #format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
  #       #format.json { render :show, status: :ok, location: @product }
  #     else
  #       #format.html { render :edit, status: :unprocessable_entity }
  #       #format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
end
