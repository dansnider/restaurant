Dir["models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant_db"
) 

### CONSOLE ###

get "/console" do
  Pry.start(binding)
  ""
end

### INDEX ###

get "/" do
	erb :index
end

### FOODS ###

get "/foods" do
  @foods = Food.all
  erb :"foods/index"
end

get "/foods/new" do
	erb :"foods/new"
end

get "/foods/:id" do
  @food = Food.find( params[:id] )
  erb :"foods/show"
end

post "/foods" do
  food = Food.create( params[:food] )
  redirect to "foods/#{food.id}"
end

get '/foods/:id/edit' do
  @food = Food.find( params[:id] )

  erb :"foods/edit"
end

patch '/foods/:id' do
  food = Food.find(params[:id])
  food.update(params[:food])

  redirect to "/foods/#{food.id}"
end

delete '/foods/:id' do
  food = Food.find(params[:id])
  food.destroy

  redirect to "/foods"
end

### PARTIES ###

get "/parties" do
  @parties = Party.all
  erb :"parties/index"
end

get "/parties/new" do
  erb :'parties/new'
end

post "/parties" do
  party = Party.create(params[:party])
  redirect to "/parties/#{party.id}"
end

get "/parties/:id" do
  @party = Party.find( params[:id] )
  erb :"parties/show"
end

get "/parties/:id/edit" do
  @party = Party.find( params[:id] )
  erb :"parties/edit"
end

patch '/parties/:id' do
  party = Party.find(params[:id])
  party.update(params[:food])

  redirect to "/parties/#{party.id}"
end

delete '/parties/:id' do
  party = Party.find(params[:id])
  party.destroy

  redirect to "/parties"
end

### ORDERS ###

get "/orders" do
  @orders = Order.all
  erb :"orders/index"
end

get "/orders/new" do
  erb :'orders/new'
end

post "/orders" do
  order = Order.create(params[:order])
  redirect to "/orders/#{order.id}"
end

get "/orders/:id" do
  @order = Order.find( params[:id] )
  erb :"orders/show"
end





