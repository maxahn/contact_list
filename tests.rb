require_relative 'contact'
require 'pry'
require 'csv'


CSV.open(Contact::File_Path, 'w') do |csv|
   csv << ['Maxwell', 'maxwell@awesome.com','0']
end

@test_file = CSV.read(Contact::File_Path)

puts '#CREATE --------------------------'

  puts "Test File, should have ONE element: #{@test_file}" 

  @rocky = Contact.create('Rocky','perogies@village.com')
  @jade = Contact.create('Jade', 'bunnypower@sleepy.com')


  @test_file = CSV.read(Contact::File_Path)
  puts "Test File, should have THREE elements: #{@test_file}"

puts '#ALL -----------------------------'
  contacts = Contact.all
  contacts.each do |contact|
  puts "Name: #{contact.name}, email: #{contact.email}, id: #{contact.id}"
  end

puts 'FIND -----------------------------'

puts "Find Rocky by ID #1"

  contact_found = Contact.find(1)
  puts "Found: #{contact_found.name}"
  puts "Trying to find non-existing contact with ID # 100"
  puts "Found: #{Contact.find(100).class}"
  
puts 'SEARCH ---------------------------'

  puts "Searching for contacts with the letter 'awesome':"
  Contact.search("max").each {|contact| puts "Name: #{contact.name}"}

  puts "Searching for contacts with the letter 'A':"
  Contact.search("a").each {|contact| puts "Name: #{contact.name}"}

  Contact.create("Julie", "sheepPower@sleepy.com")

  puts "Searching for contacts with the letter 'sleePy':"
  Contact.search("sleePy").each {|contact| puts "Name: #{contact.name}"}

File.delete(Contact::File_Path)                   #to clear file  






























#describe Contact do

# @@test_file_path = './test_contact.csv' 

# before :each do 

#   File.delete(Contact::File_Path)                   #to clear file  

#   @name = 'John Doe'
#   @email = 'johndoe@maxahn.com'
#   @new_contact = Contact.create(@name, @email)

#   @maxwell = Contact.create('Maxwell', 'maxwell@awesome.com')
#   @jade = Contact.create('Jade', 'bunnypower@sleepy.com')
#   @rocky = Contact.create('Rocky','perogies@village.com')
#   @maximus = Contact.create('Maximus', 'sheeppower@sleepy.com') 

#   @test_file = CSV.read(Contact::File_Path)
# end

# describe '.new' do
#   before :each do 
#     @contact = Contact.new('Maxwell', 'maxahn@maxahn.com')
#   end
#   it 'should be able to report its name' do
#     expect(@contact.name).to eq('Maxwell')
#   end

#   it 'should be able to report its email' do
#     expect(@contact.email).to eq('maxahn@maxahn.com')
#   end
# end

# describe '#create' do
#   
#   it 'should return the newly made contact' do
#     expect(@new_contact.name).to eq(@name)
#     expect(@new_contact.email).to eq(@email)
#   end
#   it 'should increment id number' do
#     newer_contact = Contact.create('someone','emaillll')
#     expect(newer_contact.id).to eq(@maximus.id + 1)
#   end 

#   it 'adds newly created contact to the csv file' do
#     expect(@test_file.include?(['John Doe', 'johndoe@maxahn.com', @new_contact.id.to_s])).to be true 
#   end
#   
#   it 'adds multiple contacts' do 
#     more_contact = Contact.create('Bob', "bob@gmail.com")
#     expect(@test_file).to include(['John Doe', 'johndoe@maxahn.com', @new_contact.id.to_s])
#     expect(@test_file).to include(['Bob',"bob@gmail.com", more_contact.id.to_s]) 
#   end

# end

# describe '#all' do

#   it 'should return an array of all Contact instances made from data in contacts.csv' do
#     expect(Contact.all).to eq([@maxwell,@jade,@rocky,@maximus])
#   end
#
# end

# describe '#find' do
#   
#   it 'should return contact in .csv file with matching id' do
#     found_contact = Contact.find(123)
#     expect(found_contact).to eq(@maxwell)
#   end
#  
#   it 'should return another contact in .csv file with matching id' do
#     found_contact = Contact.find(332)
#     expect(found_contact).to eq(@rocky)
#   end

#   it 'should return nil if .csv file does not contain match with id' do 
#     found_contact = Contact.find(234234234)
#     expect(found_contact).to eq(nil)
#   end
# end

#  describe '#search' do

#   it 'should search by email[full] and return an array of matching contacts' do
#      found_contacts = Contact.search('maxwell@awesome.com')
#      expect(found_contacts).to eq([@maxwell])
#   end

#   it 'should search by name[full] and return an array of matching contacts' do
#     found_contacts = Contact.search('Jade')
#     expect(found_contacts).to eq([@jade])
#   end

#   it 'should search by email[partial] and return an array of matching contacts' do
#     found_contacts = Contact('@village.com')
#     expect(found_contacts).to eq([@rocky])
#   end

#   it 'should return all the contacts containing the search term (email)' do
#     found_contacts = Contact.search('sleepy')
#     expect(found_contacts).to eq([@jade, @maximus])
#   end 
# 
#   it 'should return all the contacts containing the search term (name)' do
#     found_contacts = Contact.search('Max')
#     expect(found_contacts).to eq([@maxwell, @maximus])
#   end

#   it 'should search by name[partial] and return an array of matching contacts' do
#     found_contacts = Contact.search('Ro')
#     expect(found_contacts).to eq([@rocky])
#   end
#   
#   it 'should return matching results from both the email and name fields' do
#     found_contacts = Contact.search('a')
#     expect(found_contacts).to eq([@maxwell, @jade, @rocky, @maximus]) 
#   end
#  end
#end

  
