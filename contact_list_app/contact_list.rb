#!/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby

require_relative 'models/config'

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
          query_result = Contact.all.limit(5).offset(offset)
          query_result.each { | contact | puts "ID: #{contact.id} Name: #{contact.name} Email: #{contact.email}" }
          offset += 5
          puts "Press ENTER for more. Type anything to exit."
          input = STDIN.gets
        end while input == "\n"

      when "new"
        begin
          print "Enter a name: "
          name = STDIN.gets.strip
          print "Enter an email: "
          email = STDIN.gets.strip.downcase
          Contact.create(name: name, email: email)
        end
        
      when "show" 
        id = arguments.shift.to_i
        query_result = Contact.find(id)
        if query_result
          puts "ID: #{query_result.id}"
          puts "Name: #{query_result.name}"
          puts "Email: #{query_result.email}"
          puts "Numbers for this contact:"
          if query_result.numbers.size > 0
            query_result.numbers.each { |number| puts number.phone_number }
          else 
            puts "No numbers for this contact."
          end
        else
          puts "No contact details for this ID."
        end
        
      when "search"
        search_term = "%#{arguments.shift.to_s}%"
        query_result = Contact.where("name ILIKE ?",[search_term])
        query_result.each { | contact | puts "ID: #{contact.id} Name: #{contact.name} Email: #{contact.email}" }

      when "update"
        id = arguments.shift.to_i
        query_result = Contact.find(id)
        if query_result
          print "Enter a name: "
          query_result.name = STDIN.gets.strip
          print "Enter an email: "
          query_result.email = STDIN.gets.strip
          query_result.save
        else
          puts "No contact details for this ID."
        end

      when "destroy"
        id = arguments.shift.to_i
        query_result = Contact.find(id)
        if query_result
          query_result.destroy
        else
          puts "Contact does not exist."
        end

      when "number"
        id = arguments.shift.to_i
        query_result = Contact.find(id)
        if query_result
          print "Enter a number: "
          query_result.numbers.create(phone_number: STDIN.gets.strip)
          puts "Added number to #{query_result.name}"
        else
          puts "No contact details for this ID."
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
    puts "  show <id>- Show a contact's details including phone numbers"
    puts "  search <term>- Searches contacts in either email or name by the term."
    puts "  update <id> - Update contact with that id"
    # TODO - Add a add/delete option to the number case statement
    puts "  number <id> - Add number to a contact with that id"
  end

end

app = ContactList.new.run(ARGV)