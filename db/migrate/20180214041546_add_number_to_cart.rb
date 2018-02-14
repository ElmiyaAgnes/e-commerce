class AddNumberToCart < ActiveRecord::Migration[5.0]
  def change
  	add_column :carts, :number, :integer
  end
end
