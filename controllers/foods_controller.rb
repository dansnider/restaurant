class FoodsController < ApplicationController

	get "/" do
	  @foods = Food.all
	  erb :"foods/index"
	end

	get "/new" do
		erb :"foods/new"
	end

	get "/:id" do |id|
	  @food = Food.find(id)
	  erb :"foods/show"
	end

	post "/" do
	  food = Food.create( params[:food] )
	  
	  if food.valid?
	    redirect to "foods/#{food.id}"
	  else
	    @food = food
	    @error_messages = food.errors.messages

	    erb :'foods/new'
	  end
	  
	end

	get '/:id/edit' do
	  @food = Food.find( params[:id] )

	  erb :"foods/edit"
	end

	patch '/:id' do
	  food = Food.find(params[:id])
	  food.update(params[:food])

	  redirect to "/foods/#{food.id}"
	end

	delete '/:id' do
	  food = Food.find(params[:id])
	  food.destroy

	  redirect to "/foods"
	end
end