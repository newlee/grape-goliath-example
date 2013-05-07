require 'uri'
require 'em-synchrony/activerecord'
require 'yaml'
require 'erb'

environment = ENV['DATABASE_URL'] ? 'production' : 'development'
db = YAML.load(ERB.new(File.read('config/database.yml')).result)[environment]
ActiveRecord::Base.establish_connection(db)

