Dir["models/*.rb"].each do |file|
  require_relative file
end

enable :sessions
set :app_password, "northeast"


ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant_db"
) 

configure do
  set :scss, {:style => :compressed, :debug_info => false}
end

get '/css/:name.css' do |name|
  content_type :css
  scss "../public/sass/#{name}".to_sym, :layout => false
end

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
  @password = session[:password]
  if @password == settings.app_password
	  erb :"foods/new"
  else
    "Please set your password by visiting /set/password/:password"
  end
end

get "/foods/:id" do |id|
  @food = Food.find(id)
  erb :"foods/show"
end

post "/foods" do
  food = Food.create( params[:food] )
  
  if food.valid?
    redirect to "foods/#{food.id}"
  else
    @food = food
    @error_messages = food.errors.messages

    erb :'foods/new'
  end
  
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
  @password = session[:password]
  if @password == settings.app_password
    erb :'parties/new'
  else
    "Please set your password by visiting /set/password/:password"
  end
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

get "/orders/:id/new" do |id|
  @party = Party.find(id)
  @orders = @party.foods
  @foods = Food.all
  @password = session[:password]

  if @password == settings.app_password && @party.has_paid == false
    erb :'orders/new'
  else
    erb :error
  end
end

post "/orders/:id/new" do
  order = Order.create(params[:order])
  party = Party.find(params[:id])
  redirect to "/orders/#{party.id}/new"
end

get "/orders/:id" do |id|
  @party = Party.find(id)
  @foods = @party.foods
  # @orders = Order.where("party_id = #{params[:id]}")
  erb :"orders/show"
end

delete '/orders/:id/new' do |id|
  food_id = params[:food]["id"]
  order = Order.find_by(food_id: food_id, party_id: id)
  order.destroy
  party = Party.find(id)
  redirect to "/orders/#{party.id}/new"
end

### SESSIONS ###

get '/set/password/:password' do |password|
  session[:password] = password
  redirect to('/')
end






