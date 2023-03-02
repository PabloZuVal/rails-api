class Api::V1::CreditCardsController < ApplicationController
  
  before_action :set_credit_card, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @credit_cards = CreditCard.all
    return render json: {msj: "Credit card list empty"}, status: :unprocessable_entity unless @credit_cards

    return render json: @credit_cards, status: :ok

    # if @credit_cards 
    #   render json: @credit_cards, status: :ok
    # else
    #   render json: {msj: "Credit card list empty"}, status: :unprocessable_entity
    # end
  end

  def create
    # validate if user_id exist
    @user = User.find(credit_card_params[:user_id])
    return render json: { msj: 'user_id not founded', status: :unprocessable_entity } unless @user.present?

    @credit_card = CreditCard.new(credit_card_params)
    return render json: { msj: 'Credit card not added', status: :unprocessable_entity } unless @credit_card.save

    return render json: @credit_card, status: :ok
  end

  # PATCH/PUT /credit_cards/1 or /credit_cards/1.json
  def update
    
  end

  # DELETE /credit_cards/1 or /credit_cards/1.json ---------------------------- 
  def destroy
    return render json: { msj: 'Credit card not found', status: :unprocessable_entity } unless @credit_card.present?
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
