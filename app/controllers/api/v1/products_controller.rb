require 'net/http'

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

  def get_pokemons
    uri = URI('https://pokeapi.co/api/v2/pokemon/')
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)

    response["results"].each do |product|
      # print "\n product: \n"
      # print product["name"]
      # print "\n"
      # If pokemon already exists, it is not saved
      @product = Product.find_by(name: product["name"])
      next if @product

      @product = Product.new(name: product["name"], description: product["url"], stock: 0, price: 0, category_id: "63f78448c517c21e4eb666f9")
      return render json: { msj: "Pokemon is not saverd", error: @product.errors, status: :unprocessable_entity} unless @product.save
    end

    return render json: { msj: "Products requested" }, status: :ok
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
