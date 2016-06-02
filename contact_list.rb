require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  command = ARGV[0]

  case command

  when 'list'
    contacts = Contact.all
    contacts.each {|contact| puts "Name: #{contact.name}, Email: #{contact.email}"}
  when 'new'
    if ARGV[1] == nil
      puts "Please enter the name and email of the contact you would like to create."
    elsif ARGV[2] == nil 
      puts "Please enter the email as well."
    else 
      Contact.create(ARGV[1].to_s, ARGV[2].to_s)
    end
  when 'show'
    contact_found = Contact.find(ARGV[1])
    if contact_found != nil
      puts "Found contact:"
      puts "Name: #{contact_found.name}, Email: #{contact_found.email}"
    else 
      puts "No contact was found with id '#{ARGV[1]}"
    end
  when 'search'
    contacts_found = Contact.search(ARGV[1])
    puts "Found the following contacts:"
    if contacts_found 
        contacts_found.each {|contact| puts "Name: #{contact.name}, Email: #{contact.email}"}
    else
      puts "No contacts were found containing '#{ARGV[1]}'"
    end 
  else 
    puts 'Here is a list of available commands.'
    puts '  new     - Create a new contact'
    puts '  list    - List all contacts'
    puts '  show    - Show a contact'
    puts '  search  - Search contacts'
  end  
end
