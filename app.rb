# frozen_string_literal: true

require "sinatra"
require "sinatra/activerecord"
require "haml"

if Sinatra::Base.environment == :development
  require "pry"
  require "dotenv"
  Dotenv.load
end

require "./config/environments" # database configuration
require "./models/album"
require "./models/artist"
require "./models/song"
require "./models/todo"
require "./models/user"
require "./models/channel"
require "./models/channel_membership"
require "./models/config"

helpers do
  def authorized?
    username = ENV["ADMIN_USERNAME"]
    password = ENV["ADMIN_PASSWORD"]
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [username,
                                                                                     password]
  end

  def model_params
    params.keep_if { |key, _value| [:id].include? key }
  end

  def setup_database(sql_file)
    run_sql_file("sql/reset_db.sql")
    run_sql_file(sql_file)
  end

  def run_sql_file(sql_file)
    sql = File.read(sql_file)
    ActiveRecord::Base.connection.execute(sql)
  end
end

before do
  return if authorized?

  headers["WWW-Authenticate"] = 'Basic realm="Restricted Area"'
  halt 401, "Not authorized\n"
end

get "/" do
  @db = URI.parse(ENV["DATABASE_URL"])
  @current_status = Config.current_status
  case @current_status
  when "todo"
    @todos = Todo.all
  when "song"
    @artists = Artist.all
  when "chat"
    @users = User.all
    @channels = Channel.all
  end
  haml :index
end

post "/setup" do
  case params["config"]
  when "todo"
    setup_database("sql/todo_create.sql")
  when "song"
    setup_database("sql/song_create.sql")
  when "chat"
    setup_database("sql/chat_create.sql")
  end
  redirect "/"
end

after do
  # Close the connection after the request is done so that we don't
  # deplete the ActiveRecord connection pool.
  ActiveRecord::Base.connection.close
end
