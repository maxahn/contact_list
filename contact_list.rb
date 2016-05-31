require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  command = ARGV[0]

  case command

  when 'list'
    Contact.all
  when 'new'

  when 'show'

  when 'search'

  else
    puts 'Here is a list of available commands.'
    puts '  new     - Create a new contact'
    puts '  list    - List all contacts'
    puts '  show    - Show a contact'
    puts '  search  - Search contacts'
  end  
end
