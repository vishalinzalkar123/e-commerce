class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    # products = Product.all -- old
    # products = Product.includes(:category, :reviews) --2nd old
    products = Products::FilterQuery.new(Product.includes(:category, :reviews), params).call
    render json: products
  end

  def show
    render json: @product
  end

  def create
    product = Product.new(product_params)
    authorize product

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @product

    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product

    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end