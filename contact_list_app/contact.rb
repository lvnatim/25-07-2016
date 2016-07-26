require 'csv'

class ContactError < StandardError
end

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_reader :id

  attr_accessor :name, :email
  
  @@current_id = 1
  @@contacts = []
  @@filename = "MOCK_DATA.csv"
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email, contact_info={})
    # TODO: Assign parameter values to instance variables.
    @id = @@current_id
    @@current_id += 1
    @name = name
    @email = email
    @contact_info = contact_info
  end

  def to_s
    "#{id}: #{name} (#{email})"
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    def contacts
      @@contacts
    end

    def contact_values_empty?(contact)
      true if contact[0] == nil || contact[1] == nil
    end

    def in_bounds?(id)
      if id > @@contacts.length || id <= 0
        true 
      else
        false
      end
    end

    def raise_duplicate_email_error(email)
      @@contacts.each do |contact|
        raise ContactError, "That email already exists in the database!" if contact.email.downcase == email.downcase
      end
    end

    def load_contacts(filename)
      contacts_data = CSV.read(filename)
      contacts_data.each do | contact |
        begin
          raise ContactError, "Name and email values should not be nil in csv." if contact_values_empty?(contact)
          name = contact[0].strip
          email = contact[1].strip
          @@contacts << Contact.new(name, email)
        rescue ContactError => ex
          puts "#{ex.message}"
        end
      end

    end

    def create(name, email, number={})
      contacts_data = CSV.open(@@filename, 'a+')
      contact = Contact.new(name, email, number)
      contacts_data << [name, email, number]
      "Contact has succesfully been initialized with an ID of #{contact.id}."
    end
    
    # Find the Contact in the 'MOCK_DATA.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'MOCK_DATA.csv' file with the matching id.
      begin
        raise IndexError, "That ID is out of bounds." if in_bounds?(id)
        index = id - 1
        return [@@contacts[index], nil]
      rescue IndexError => ex
        puts "#{ex.message}"
        return nil
      end

    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'MOCK_DATA.csv' file whose name or email attributes contain the search term.
      found_contacts = @@contacts.select do |contact|
        contact.name.downcase.include?(term.downcase) || contact.email.downcase.include?(term.downcase)
      end
      found_contacts

    end

  end

end
