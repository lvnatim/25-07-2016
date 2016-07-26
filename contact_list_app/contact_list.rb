#!/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby

require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  attr_reader :contacts

  def initialize(filename)
    
    Contact.load_contacts(filename)
    @contacts = Contact.contacts

    user_command = ARGV[0]

    if user_command
      input = user_command.downcase
      case input

      when "list"
        start_index = 0
        end_index = 4
        puts contacts[start_index..end_index]
        loop do
          begin
            print "Press enter for next 5 contacts, or press any other key followed by enter to exit."
            check_enter_key = get_user_input
            break if check_enter_key != "\n"
            start_index += 5
            end_index += 5
            raise IndexError, "You are at the end of the list!" if end_index >= contacts.count
            puts contacts[start_index..end_index]
          rescue IndexError => ex
            end_index = contacts.count
            puts contacts[start_index...end_index]
            puts "#{ex.message}"
          end
        end

      when "new"
        begin
          print "Enter a name: "
          name = get_user_input.strip
          print "Enter an email: "
          email = get_user_input.strip
          Contact.raise_duplicate_email_error(email)
          contact_info = {}

          loop do
            print "Would you like to enter a number? (Y for YES): "
            response = get_user_input.strip.upcase
            if response == 'Y'
              print "Enter a label (mobile, home, etc.): "
              label = get_user_input.strip
              print "Enter a number: "
              number = get_user_input.strip
              contact_info[label] = number
            else
              break
            end
          end
        
          puts Contact.create(name, email, contact_info)

        rescue ContactError => ex
          puts "#{ex.message}"
        end

      when "show"
        id = ARGV[1].to_i
        contact = Contact.find(id)
        puts contact[0].name
        puts contact[0].email

      when "search"
        search_term = ARGV[1].to_s
        puts return_array = Contact.search(search_term)
        puts "---"
        puts "#{return_array.length} record(s) total."

      else
        puts "That isn't a valid command. Type 'ruby.rb contact_list.rb' for a list of commands!'"
      end

    else
      run
    end

  end

  def run
    puts "Here is a list of available commands:"
    puts "  new - Create a new contact"
    puts "  list - List all contacts"
    puts "  show - Show a contact"
    puts "  search - Search contacts"
  end

  def get_user_input
    STDIN.gets
  end

end

app = ContactList.new('MOCK_DATA.csv')