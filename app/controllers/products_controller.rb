class ProductsController < ApplicationController
  before_action :check_admin_priv, only: %i[ new create edit update destroy ]
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @keyword = params[:keyword]
    @category_id = params[:category]

    @products = Product.all
    @products = @products.where("name LIKE ? OR description LIKE ?", "%#{@keyword}%", "%#{@keyword}%") if @keyword.present?
    @products = @products.where(category_id: @category_id) if @category_id.present?
    @products = Product.paginate(page: params[:page], per_page: 8)

    @categories = Category.all
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

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    new_product_params = product_params.to_unsafe_h
    new_product_params.delete("images") if new_product_params["images"].all?(&:blank?)
    respond_to do |format|
      if @product.update(new_product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :category_id, :price, images: [])
    end
end
