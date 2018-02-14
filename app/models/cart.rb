class Cart < ActiveRecord::Base
  has_many :products, through: :ordered_items, dependent: :destroy
  has_many :ordered_items, dependent: :destroy
end
