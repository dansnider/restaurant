class Food < ActiveRecord::Base
	has_many :orders
	has_many :parties, through: :orders

validates :name, uniqueness: { 
	case_sensitive: false, 
	message: "This name is already taken."
}
end