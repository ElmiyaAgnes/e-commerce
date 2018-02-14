# Add shipping and tax to order total
class ShippingMethod
	def self.call(params)
		case params[:order][:shipping_method]
		when 'ground'
			(@order.taxed_total).round(2)
		when 'two-day'
			@order.taxed_total + (15.75).round(2)
		when "overnight"
			@order.taxed_total + (25).round(2)
		end
	end
end