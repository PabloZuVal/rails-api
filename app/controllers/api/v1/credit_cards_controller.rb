class Api::V1::CreditCardsController < ApplicationController
  before_action :set_credit_card, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @credit_cards = CreditCard.all

    if @credit_cards 
      render json: @credit_cards, status: :ok
    else
      render json: {msj: "Credit card list empty"}, status: :unprocessable_entity
    end

  end

  def create
    # validate if user_id exist

    @credit_card = CreditCard.new(credit_card_params)

    if @credit_card.save
      render json: @credit_card, status: :ok
    else
      render json: {msj: 'Credit card not added', status: :unprocessable_entity}
    end
  end

  # PATCH/PUT /credit_cards/1 or /credit_cards/1.json
  def update
    
  end

  # DELETE /credit_cards/1 or /credit_cards/1.json
  def destroy
    @credit_card.destroy

    respond_to do |format|
      format.html { redirect_to credit_cards_url, notice: "Credit card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def credit_card_params
      params.permit(:number_card, :expiration_date, :security_code, :user_id)
    end
end
