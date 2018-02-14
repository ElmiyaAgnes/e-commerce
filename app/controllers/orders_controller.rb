class OrdersController < ApplicationController
  before_action :get_cart

  # process order
  def create
    @order = Order.new(order_params)
    @order.cart_id = @cart.id
    # Add items from cart to order's ordered_items association
    @cart.ordered_items.each do |item|
      @order.ordered_items << item
    end

    @order.total = ShippingMethod.call(params) #call service for tax calculation based on shipping_method
    credit_card_obj = CreditCard.new()
    credit_card_obj.call(params, @order) #call service for creditcard
    @order.order_status = 'processed'

    if @order.save
      SaveOrder.call(session, order_params)
      flash[:success] = "You successfully ordered!"
      redirect_to confirmation_orders_path
    else
      flash[:error] = "There was a problem processing your order. Please try again."
      render :new
    end
  end

  def order_params
    params.require(:order).permit!
  end

  def get_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
  end
end
