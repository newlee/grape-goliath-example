require "rubygems"
require "bundler/setup"
require 'em-synchrony/activerecord'
require 'yaml'
require 'erb'

namespace :db do
  def run_sql_cmd(cmd)
    sql_cmd = %Q|mysql -u#{config['username']} -p#{config['password']} -e "#{cmd}"|
    system sql_cmd
  end

  desc "loads database configuration in for other tasks to run"
  task :load_config do
    ActiveRecord::Base.configurations = db_conf

  end
  
  desc "creates and migrates your database"
  task :setup => :load_config do
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end
  
  desc "migrate your database"
  task :migrate do
    ActiveRecord::Base.establish_connection db_conf["production"]

    ActiveRecord::Migrator.migrate(
      ActiveRecord::Migrator.migrations_paths, 
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end
  
  desc 'Drops the database'
  task :drop => :load_config do
    ActiveRecord::Base.connection.drop_database db_conf['production']['database']
  end
  
  desc 'Creates the database'
  task :create => :load_config do
    ActiveRecord::Base.connection.create_database db_conf['production']['database']
  end
  
end

def db_conf
  config = YAML.load(ERB.new(File.read('config/database.yml')).result)
end
