class DetailPurchesesController < ApplicationController
  before_action :set_detail_purchese, only: %i[ show edit update destroy ]

  # GET /detail_purcheses or /detail_purcheses.json
  def index
    @detail_purcheses = DetailPurchese.all
  end

  # GET /detail_purcheses/1 or /detail_purcheses/1.json
  def show
  end

  # GET /detail_purcheses/new
  def new
    @detail_purchese = DetailPurchese.new
  end

  # GET /detail_purcheses/1/edit
  def edit
  end

  # POST /detail_purcheses or /detail_purcheses.json
  def create
    @detail_purchese = DetailPurchese.new(detail_purchese_params)

    respond_to do |format|
      if @detail_purchese.save
        #format.html { redirect_to detail_purchese_url(@detail_purchese), notice: "Detail purchese was successfully created." }
        #format.json { render :show, status: :created, location: @detail_purchese }
      else
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @detail_purchese.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detail_purcheses/1 or /detail_purcheses/1.json
  def update
    respond_to do |format|
      if @detail_purchese.update(detail_purchese_params)
        #format.html { redirect_to detail_purchese_url(@detail_purchese), notice: "Detail purchese was successfully updated." }
        #format.json { render :show, status: :ok, location: @detail_purchese }
      else
        #format.html { render :edit, status: :unprocessable_entity }
        #format.json { render json: @detail_purchese.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detail_purcheses/1 or /detail_purcheses/1.json
  def destroy
    @detail_purchese.destroy

    respond_to do |format|
      #format.html { redirect_to detail_purcheses_url, notice: "Detail purchese was successfully destroyed." }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail_purchese
      @detail_purchese = DetailPurchese.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def detail_purchese_params
      params.require(:detail_purchese).permit(:quantity, :subtotal)
    end
end
