module CartsHelper
	def get_product_names(cart)
		Product.find(cart.ordered_items.map(&:product_id)).map(&:name) unless cart.ordered_items.map(&:product_id).first.nil?
	end

	def get_total_price(cart)
		Order.where(cart_id: cart.id).first.total unless Order.where(cart_id: cart.id).first.nil?
	end
end
