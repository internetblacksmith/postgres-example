# frozen_string_literal: true

namespace :setup do
  desc "configure the database with the todo example"
  task :todo do
    setup_database("sql/todo_create.sql")
  end

  desc "configure the database with the song example"
  task :song do
    setup_database("sql/song_create.sql")
  end

  desc "configure the database with the chat example"
  task :chat do
    setup_database("sql/chat_create.sql")
  end

  desc "bootstrap the application"
  task :bootstrap do
    Rake::Task["db:create"].invoke unless ENV["RACK_ENV"] == "production"
    Rake::Task["setup:todo"].invoke
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
