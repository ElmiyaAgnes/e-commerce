class CartsController < ApplicationController
  def index
    @carts = Cart.all
    @products = Product.pluck(:name, :id)
  end

  def new
    @cart = Cart.new
  end

  def create
    cart = Cart.create(number: permitted_params[:cart_number])
    order_item = OrderedItem.create(cart_id: cart.id, product_id: permitted_params[:product], quantity: permitted_params[:product_count])
    cart.save
    order_item.save
    redirect_to root_path
  end

  def permitted_params
    params.require(:cart).permit(:cart_number, :product, :product_count)
  end

end
