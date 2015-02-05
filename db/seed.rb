require 'pg'
require 'active_record'
require 'pry'
Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
  adapter: :postgresql,
  database: :restaurant_db,
  host: :localhost,
  port: 5432
	)

[
  {
    name: "Clawhammer Farm Pork Ragout",
    category: "Entree",
    description: "Black Trumpet Mushroom, Pistachio, Kale, Ricotta",
    price: 18, 
    vegetarian: false,
    has_gluten: true,
    has_nuts: false,
    has_dairy: true
  },
  {
    name: "Amish Chicken",
    category: "Entree",
    description: "Turnips, Kohlrabi, Carrots, Barley, Brodo",
    price: 23, 
    vegetarian: false,
    has_gluten: false,
    has_nuts: false,
    has_dairy: false
  },
  {
    name: "Nantucket Bay Scallops",
    category: "Starter",
    description: "Golden Beet, Baby Carrots, Yuzu",
    price: 13, 
    vegetarian: false,
    has_gluten: false,
    has_nuts: false,
    has_dairy: false
  },
  {
    name: "Winter Greens",
    category: "Starter",
    description: "Watermelon Radish, Parmesan, Pecan",
    price: 23, 
    vegetarian: true,
    has_gluten: false,
    has_nuts: false,
    has_dairy: false
  },
  {
    name: "Panna Cotta",
    category: "Dessert",
    description: "Almond, Coconut, Kahlua",
    price: 7, 
    vegetarian: true,
    has_gluten: false,
    has_nuts: false,
    has_dairy: true
  }
].each do |food|
  Food.create( food )
end



# <<-SQL
# CREATE TABLE foods (
# 	id SERIAL PRIMARY KEY,
# 	name VARCHAR(255) NOT NULL,
# 	category VARCHAR(255) NOT NULL,
# 	description VARCHAR(255) NOT NULL,
# 	price NUMERIC NOT NULL,
# 	vegetarian BOOLEAN NOT NULL,
# 	has_gluten BOOLEAN NOT NULL,
# 	has_nuts BOOLEAN NOT NULL,
# 	has_dairy BOOLEAN NOT NULL,
# 	created_at TIMESTAMP,
# 	updated_at TIMESTAMP
# 	);

# CREATE TABLE orders (
# 	id SERIAL PRIMARY KEY,
# 	party_id INTEGER NOT NULL,
# 	food_id INTEGER NOT NULL,
# 	created_at TIMESTAMP,
# 	updated_at TIMESTAMP
# 	);

# CREATE TABLE parties (
# 	id SERIAL PRIMARY KEY,
# 	table_id INTEGER,
# 	num_of_guests INTEGER NOT NULL,
# 	has_paid BOOLEAN NOT NULL
# 	);






