require 'pg'

puts 'Connecting to the database...'

con = PG.connect(
  host: 'localhost',
  dbname: 'contacts',
  user: 'development',
  password: 'development'
)



