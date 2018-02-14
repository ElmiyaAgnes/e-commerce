# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Product
Product.find_or_create_by(name: 'Fossil BQ2310 Watch - For Men', price: 4749)
Product.find_or_create_by(name: 'Samsung 192 L Direct Cool Single Door 3 Star Refrigerator', price: 12999)
Product.find_or_create_by(name: 'Jade Women Beige Heels', price: 499)
Product.find_or_create_by(name: 'SASSIE RED AND GREY SCHOOL BAG Waterproof Backpack', price: 359)
Product.find_or_create_by(name: 'Blacksmith Analog Wall Clock', price: 887)
Product.find_or_create_by(name: 'Li-Ning BADMINTON KIT BAG', price: 470)
Product.find_or_create_by(name: 'SanDisk Ultra 32 GB MicroSDHC Class 10 98 MB/s Memory Card', price: 879)
Product.find_or_create_by(name: 'Himalaya Clear Complexion Whitening Day Cream', price: 199)

# Create Cart
Cart.find_or_create_by(number: 1)

# Create Cart
OrderedItem.find_or_create_by(cart_id: 1, product_id: 1, quantity: 1)
OrderedItem.find_or_create_by(cart_id: 1, product_id: 2, quantity: 1)
OrderedItem.find_or_create_by(cart_id: 1, product_id: 4, quantity: 1)
OrderedItem.find_or_create_by(cart_id: 1, product_id: 8, quantity: 2)