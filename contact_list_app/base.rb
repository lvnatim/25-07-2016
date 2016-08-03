require 'pg'

class Base

  @@connection = nil

  def self.connection

    @@connection = @@connection || PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
    )

  end 

end