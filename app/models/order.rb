class Order < ActiveRecord::Base
	belongs_to :cart
	has_many :ordered_items, dependent: :destroy
end
