require "pry"
require "sinatra"
require "mysql2"
require "text-table"
require "vulnerable_forum/version"
require "vulnerable_forum/database"

module VulnerableForum
  SINATRA_QUOTES = [ 
    'The best revenge is massive success.', 
    'Cock your hat - angles are attitudes.', 
    'Hell hath no fury like a hustler with a literary agent.',
    'I\'m not one of those complicated, mixed-up cats.', 
    'You gotta love livin\', baby, \'cause dyin\' is a pain in the ass.', 
    'Alcohol may be man\'s worst enemy, but the bible says love your enemy.',  
  ]

  def self.sinatra_quote
    SINATRA_QUOTES.sample
  end
end

configure do
  enable :sessions
end

before do 
  headers["x-easter-egg"] = VulnerableForum.sinatra_quote
end

get '/' do
  if session[:first_name]
    first = "Welcome to the forum, #{session[:first_name]}!"
  else
    first = "Welcome to the forum!"
  end
  first + "\nTotal Users: #{VulnerableForum.db.total_number_of_users}\nTotal Posts: #{VulnerableForum.db.total_number_of_posts}\n"
end

get '/login' do
  halt 404, "Currently logged in!" if session[:user]
  "Login with user name and password.\n"
end

post '/login' do
  halt 404, "Currently logged in!\n" if session[:user_id]
  halt 404, "No username provided!\n" unless params[:username] and !params[:username].empty?
  halt 404, "No password provided!\n" unless params[:password] and !params[:password].empty?
  if user = VulnerableForum.db.login(params[:username], params[:password])
    session[:user_id] = user["id"]
    session[:user_name] = user["user_name"]
    session[:first_name] = user["first_name"]
    session[:last_name] = user["last_name"]
    session[:email] = user["email"]
    "Welcome back #{user["first_name"]}!\n" 
  else
    halt 401, "Whoa, that didn't work!\n"
  end
end

get '/logout' do
  halt 404, "You're not even logged in!\n" unless session[:user]
  session[:user] = nil
  "Bye bye!\n"
end

get '/posts' do
  VulnerableForum.db.formatted.posts
end

post '/posts' do
  halt 404, "Not logged in!" unless session[:user_id]
  halt 404, "No title!" unless params[:title] and !params[:title].empty?
  halt 404, "No content!" unless params[:title] and !params[:content].empty?
  VulnerableForum.db.query("INSERT INTO posts(user, title, content) VALUES(#{session[:user_id]}, #{params[:title]}, #{params[:content]})")
end

get '/users' do
  VulnerableForum.db.formatted.users
end
