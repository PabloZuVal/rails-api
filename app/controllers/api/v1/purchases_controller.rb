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

  # POST /purchases or /purchases.json
  def create
    # validate if user_id exist
    @user = User.find(purchase_params[:user_id])
    return render json: { msj: 'user_id not founded', status: :unprocessable_entity } unless @user.present?

    @purchase = Purchase.new(purchase_params)
    return render json: {error: "No se pudo crear la compra", status: :unprocessable_entity} unless @purchase.save
    
    return render json: @purchase, status: :created

  end

  def create_invoice
    #create invoice in purcache controller

    # ....

    
  end

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
