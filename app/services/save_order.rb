class SaveOrder
	def call(session, order_params)
		# get rid of cart
		Cart.destroy(session[:cart_id])
		# send order confirmation email
		OrderMailer.order_confirmation(order_params[:billing_email], session[:order_id]).deliver
	end
end