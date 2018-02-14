require 'active_merchant'

class CreditCard
	def initialize
		@gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
			login: ENV["AUTHORIZE_LOGIN"],
			password: ENV["AUTHORIZE_PASSWORD"]
		)
	end

	def call(params, @order)
		card_type = get_card_type(params) # Get the card type
		credit_card = get_card_details(params) # Get credit card object from ActiveMerchant

		# Check if card is valid
		if credit_card.valid?
			options = get_billing_address(params)

			# Make the purchase through ActiveMerchant
			charge_amount = (@order.total.to_f * 100).to_i
			response = @gateway.purchase(charge_amount, credit_card, options)

			if !response.success?
				@order.errors.add(:error, "We couldn't process your credit card")
			end
		else
			@order.errors.add(:error, "Your credit card seems to be invalid")
			flash[:error] = "There was a problem processing your order. Please try again."
			render :new && return
		end
	end

	def get_card_type(params)
		length = params[:card_info][:card_number].size
		if length == 15 && number =~ /^(34|37)/
			"AMEX"
		elsif length == 16 && number =~ /^6011/
			"Discover"
		elsif length == 16 && number =~ /^5[1-5]/
			"MasterCard"
		elsif (length == 13 || length == 16) && number =~ /^4/
			"Visa"
		else
			"Unknown"
		end
	end

	def get_card_details(params)
		ActiveMerchant::Billing::CreditCard.new(
			number: params[:card_info][:card_number],
			month: params[:card_info][:card_expiration_month],
			year: params[:card_info][:card_expiration_year],
			verification_value: params[:card_info][:cvv],
			first_name: params[:card_info][:card_first_name],
			last_name: params[:card_info][:card_last_name],
			type: card_type
		)
	end

	def get_billing_address(params)
		billing_address = { name: "#{params[:billing_first_name]} #{params[:billing_last_name]}",
												address1: params[:billing_address_line_1],
												city: params[:billing_city], state: params[:billing_state],
												country: 'US',zip: params[:billing_zip],
												phone: params[:billing_phone] }
		{ address: {}, billing_address: billing_address }
	end
end