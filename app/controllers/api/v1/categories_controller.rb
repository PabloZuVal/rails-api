class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
    return render json: { msj: "Category list empty" }, status: :unprocessable_entity unless @categories

    return render json: @categories, status: :ok
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    return render json: @category.errors, status: :unprocessable_entity unless @category.save

    return render json: @category, status: :created
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  # def update
  #   respond_to do |format|
  #     if @category.update(category_params)
  #       format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
  #       format.json { render :show, status: :ok, location: @category }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @category.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /categories/1 or /categories/1.json
  # def destroy
  #   @category.destroy

  #   respond_to do |format|
  #     format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.permit(:name, :description)
    end
end
