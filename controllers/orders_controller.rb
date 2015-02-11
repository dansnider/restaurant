class OrdersController < ApplicationController

	get "/" do
	  @orders = Order.all
	  erb :"orders/index"
	end

	get "/:id/new" do |id|
	  @party = Party.find(id)
	  @orders = @party.foods
	  @foods = Food.all
	  erb :'orders/new'
	end

	post "/:id/new" do
	  order = Order.create(params[:order])
	  party = Party.find(params[:id])
	  redirect to "/orders/#{party.id}/new"
	end

	get "/:id" do |id|
	  @party = Party.find(id)
	  @foods = @party.foods
	  # @orders = Order.where("party_id = #{params[:id]}")
	  erb :"orders/show"
	end

	delete '/:id/new' do |id|
	  food_id = params[:food]["id"]
	  order = Order.find_by(food_id: food_id, party_id: id)
	  order.destroy
	  party = Party.find(id)
	  redirect to "/orders/#{party.id}/new"
	end
end