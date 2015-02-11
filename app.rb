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

### SESSIONS ###

get '/set/password/:password' do |password|
  session[:password] = password
  redirect to('/')
end






