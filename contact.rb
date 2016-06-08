require 'csv'
require 'pg'
# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email, :id
  @@csv_file = './contact.csv' #'./test_contact.csv'
  @@id_tracker = 1  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  
  def initialize(name, email, id=nil)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    #id.nil? ?  @id = @@id_tracker += 1 : @id = id
    @id = id || @@id_tracker += 1
  end

  def save(id, name, email) 
      Contact.connection.exec_params('INSERT INTO contacts (id, name, email) 
                      VALUES ($1, $2, $3);', [id, name, email])
  end

  # Provides functionality for managing contacts in the csv file.
  class << self
    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    
    def connection 
      PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
      )
    end

    def initialize_id_tracker 
      @@id_tracker = all.reduce (0) {|memo, contact| contact.id > memo ? contact.id : memo}
      #@@id_tracker = all.map { |c| c.id }.reduce { |m, id| m > id ? m : id } #another way of doing the same thing
    end
     
    def all
      connection.exec('SELECT * FROM contacts;').map do |contact|
        Contact.new(contact["name"], contact["email"], contact["id"].to_i)
      end
    end

    # Creates a new contact, adding it to the contacts table, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
    # new_contact = Contact.new(name, email)
    # CSV.open(@@csv_file, 'a') do |csv|
    #   csv << [new_contact.name, new_contact.email, new_contact.id]
    # end
    # new_contact
      con = Contact.new(name, email)
      con.save(con.id, con.name, con.email)
    end
          
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
    # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
        all.find {|contact| contact.id == id.to_i} 
    end

    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
    # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      contacts = Contact.all
      new_term = term.downcase
      
      contacts.find_all do |contact|
        name = contact.name.downcase
        email = contact.email.downcase
        name.include?(new_term) || email.include?(new_term)
      end
    end
        
    def id_tracker 
      @@id_tracker
    end

    def csv_file
      @@csv_file
    end
  end
  initialize_id_tracker
end

