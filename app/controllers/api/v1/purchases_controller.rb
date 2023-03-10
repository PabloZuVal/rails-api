class Api::V1::PurchasesController < ApplicationController
  before_action :purchase_params, only:[ :create ]
  before_action :set_default_response_format
  skip_before_action :verify_authenticity_token, only: [:create]

  # before_action :set_credit_card, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token, only: [:create]
  # # GET /purchases or /purchases.json
  def index
    @purchases = Purchase.all
    return render json: {error: "No se encontraron compras"}, status: :unprocessable_entity unless @purchases.present?
    
    return render json: @purchases, status: :ok
  end

  # GET /purchases/1 or /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases or /purchases.json
  def create
    # validate if user_id exist
    @user = User.find(purchase_params[:user_id])
    return render json: { msj: 'user_id not founded', status: :unprocessable_entity } unless @user.present?

    @purchase = Purchase.new(purchase_params)
    return render json: {error: "No se pudo crear la compra", status: :unprocessable_entity} unless @purchase.save
    
    return render json: @purchase, status: :created
    # @purchase.user_id = params[:user_id]
    # @purchase.total = 0
    # @purchase.save
  

    # respond_to do |format|
    #   if @purchase.save
    #     format.json { render :show, status: :created, location: @purchase }
    #   else
    #     format.json { render json: @purchase.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def create_invoice
    
  end

  # PATCH/PUT /purchases/1 or /purchases/1.json
  # def update
  #   respond_to do |format|
  #     if @purchase.update(purchase_params)
  #       format.html { redirect_to purchase_url(@purchase), notice: "Purchase was successfully updated." }
  #       format.json { render :show, status: :ok, location: @purchase }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @purchase.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /purchases/1 or /purchases/1.json
  def destroy
    @purchase.destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.permit(:total, :user_id)
    end

    def set_default_response_format
      request.format = :json
    end
end
