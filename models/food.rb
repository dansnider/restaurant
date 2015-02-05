class Food < ActiveRecord::Base
	has_many :parties, through: :order
	has_many :orders
end