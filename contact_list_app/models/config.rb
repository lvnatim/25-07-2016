require 'active_record'
require_relative 'contact'
require_relative 'number'

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'contacts',
  username: 'development',
  password: 'development',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)