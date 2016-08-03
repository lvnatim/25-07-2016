# require 'pg'
# require 'csv'

# conn = PG.connect(
#   host: 'localhost',
#   dbname: 'contacts', 
#   user: 'development',
#   password: 'development'
# )

# data = CSV.read('MOCK_DATA.csv')
# data.each do | row |

#   conn.exec("INSERT INTO contacts (name, email) VALUES ($1, $2)", [row[0],row[1]])

# end