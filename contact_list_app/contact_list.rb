#!/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby

require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def initialize
  end

  def run(arguments)

    user_command = arguments.shift

    if user_command
      input = user_command.downcase

      case input

      when "list"      
        offset = 0  
        begin
          puts Contact.all(offset)
          offset += 5
          puts "Press ENTER for more. Type anything to exit."
          input = STDIN.gets
        end while input == "\n"

      when "new"
        begin
          contact_entry = Contact.new
          print "Enter a name: "
          contact_entry.name = STDIN.gets.strip
          print "Enter an email: "
          contact_entry.email = STDIN.gets.strip
          contact_entry.save
        rescue EmailAlreadyExistsError
          puts "Insert aborted. Contact already exists."
        end
        
      when "show" 
        id = arguments.shift.to_i
        contact_entry = Contact.find(id)
        if contact_entry
          puts contact_entry
          puts "Numbers for this contact:"
          puts contact_entry.numbers
        else
          puts "No contact details for this ID."
        end
        
      when "search"
        search_term = arguments.shift.to_s
        contact_entries = Contact.search(search_term)
        puts contact_entries

      when "update"
        id = arguments.shift.to_i
        contact_entry = Contact.find(id)
        print "Enter a name: "
        contact_entry.name = STDIN.gets.strip
        print "Enter an email: "
        contact_entry.email = STDIN.gets.strip
        contact_entry.save

        print "Would you like to add a phone number? (Y for YES)"
        if STDIN.gets.upcase.strip == 'Y'
          print "Enter a number: "
          contact_entry.add_number(STDIN.gets.strip)
          puts "Added number to #{contact_entry}"
        end

      when "destroy"
        id = arguments.shift.to_i
        contact_entry = Contact.find(id)
        if contact_entry
          contact_entry.destroy
        else
          puts "Contact does not exist."
        end

      else
        puts "That isn't a valid command. Type './contact_list.rb' for a list of commands!'"
      end

    else
      show_commands
    end

  end

  def show_commands
    puts "Here is a list of available commands:"
    puts "  new - Create a new contact"
    puts "  list - List all contacts"
    puts "  show - Show a contact's including phone numbers"
    puts "  search - Search contacts"
    puts "  update - Update contacts"
  end

end

app = ContactList.new.run(ARGV)