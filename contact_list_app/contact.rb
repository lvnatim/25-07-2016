require 'csv'
require 'pg'
require_relative 'base'

class EmailAlreadyExistsError < StandardError
end

class ContactDoesntExistError < StandardError
end

class Contact < Base

  attr_reader :id

  attr_accessor :name, :email, :numbers
  
  def initialize(row={})
    @id ||= row["id"]
    @name ||= row["name"]
    @email ||= row["email"]
  end

  def destroy
    query = Contact.connection.exec_params('
      DELETE FROM contacts
      WHERE id = $1::int;',
      [id]
    )
  end

  def save
    unless id
      raise EmailAlreadyExistsError, "That email already exists!" if Contact.exists_email?(email)
      query = Contact.connection.exec_params('
        INSERT INTO contacts (name, email) 
        VALUES ($1, $2) 
        RETURNING id, name, email;',
        [name, email]
      )
    else
      query = Contact.connection.exec_params('
        UPDATE contacts SET name = $2, email = $3
        WHERE id = $1
        RETURNING id, name, email;',
        [id, name, email]
      )
    end
  end

  def add_number(number_string)
    query = Contact.connection.exec_params('
      INSERT INTO numbers (contact_id, phone_number)
      VALUES ($1, $2);',
    [id, number_string]
    )
  end

  def to_s
    "ID: #{id} NAME: #{name} EMAIL: #{email}"
  end

  def numbers
    query = Contact.connection.exec_params('
      SELECT phone_number FROM numbers
      WHERE contact_id = $1',
      [id] 
      )
    query.ntuples > 0 ? query.map{ |row| "#{row["phone_number"]}" } : "No numbers for this ID."
  end

  class << self

    def all(offset=0)
      query = self.connection.exec('
        SELECT *
        FROM contacts 
        ORDER BY id
        LIMIT 5
        OFFSET $1;',
        [offset]
      )
      query.map do | row |
        Contact.new(row)
      end
    end

    def create(name, email)
      new_entry = Contact.new
      new_entry.name = name
      new_entry.email = email
      new_entry.save
    end
    
    def find(id)
      query = self.connection.exec_params('
        SELECT * 
        FROM contacts 
        WHERE id = $1 
        LIMIT 1;',
        [id] 
        )
      Contact.new(query[0]) if query.ntuples > 0
    end

    def search(term)
      term = "%" + term + "%"
      query = self.connection.exec_params('
        SELECT *
        FROM contacts
        WHERE name ILIKE $1;',
        [term]
      )
      query.map do | row |
        Contact.new(row)
      end
    end

    def exists_email?(email)
      query = self.connection.exec_params('
        SELECT *
        FROM contacts
        WHERE email ILIKE $1;',
        [email])
      query.ntuples > 0
    end

  end

end
