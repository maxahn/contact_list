require_relative 'contact'
require_relative 'contact_list'


describe Contact do
  @@test_file = CSV.read('./test_contact.csv') 
    
  describe '.new' do
    before :each do 
      @contact = Contact.new("Maxwell", "maxahn@maxahn.com")
    end
    
    it 'should be able to report its name' do
      expect(@contact.name).to eq('Maxwell')

    end

    it 'should be able to report its email' do
      expect(@contact.email).to eq('maxahn@maxahn.com')
    end
  end

  describe '#create' do
    before :each do
      @name = 'John Doe'
      @email = 'johndoe@maxahn.com'
      @new_contact = Contact.create(@name, @email)
    end

    it 'should return the newly made contact' do
      expect(Contact.create(@name, @email)).to eq(Contact.new(@name, @email))
    end

    it 'should increment id number' do 
      expect(create('a', 'a').id).to eq(1)
    end 
    it 'adds newly created contact to the csv file' do
      expect(@@test_file.include?(['John Doe', 'johndoe@maxahn.com', 0])).to be true 
    end 
  end

  describe '#all' do 
    before :each do 
      @maxwell = Contact.new('Maxwell', 'maxwell@awesome.com', 123)
      @jade    = Contact.new('Jade', 'bunnypower@sleepy.com', 2333)
      @rocky   = Contact.new('Rocky','perogies@village.com', 332)
    end

    it 'should return an array of all Contact instances made from data in contacts.csv' do
      expect(Contact.all).to eq([@maxwell,@jade,@rocky])
    end
 
  end

  describe '#find' do
    it 'should return contact in .csv file with matching id' do
      found_contact = Contact.find(123)
      expect(found_contact).to eq(@maxwell)
    end
   
    it 'should return another contact in .csv file with matching id' do
      found_contact = Contact.find(332)
      expect(found_contact).to eq(@rocky)
    end

    it 'should return nil if .csv file does not contain match with id' do 
      found_contact = Contact.find(234234234)
      expect(found_contact).to eq(nil)
    end
  end

  describe '#search' do

    before :each do 
      @maxwell = Contact.new('Maxwell', 'maxwell@awesome.com', 123)
      @jade    = Contact.new('Jade', 'bunnypower@sleepy.com', 2333)
      @rocky   = Contact.new('Rocky','perogies@village.com', 332)
      @maximus = Contact.new('Maximus', 'sheeppower@sleepy.com', 144) 
    end
    
    it 'should search by email[full] and return an array of matching contacts' do
       found_contacts = Contact.search('maxwell@awesome.com')
       expect(found_contacts).to eq([@maxwell])
    end

    it 'should search by name[full] and return an array of matching contacts' do
      found_contacts = Contact.search('Jade')
      expect(found_contacts).to eq([@jade])
    end

    it 'should search by email[partial] and return an array of matching contacts' do
      found_contacts = Contact('@village.com')
      expect(found_contacts).to eq([@rocky])
    end

    it 'should return all the contacts containing the search term (email)' do
      found_contacts = Contact.search('sleepy')
      expect(found_contacts).to eq([@jade, @maximus])
    end 
  
    it 'should return all the contacts containing the search term (name)' do
      found_contacts = Contact.search('Max')
      expect(found_contacts).to eq([@maxwell, @maximus])
    end

    it 'should search by name[partial] and return an array of matching contacts' do
      found_contacts = Contact.search('Ro')
      expect(found_contacts).to eq([@rocky])
    end
    
    it 'should return matching results from both the email and name fields' do
      found_contacts = Contact.search('a')
      expect(found_contacts).to eq([@maxwell, @jade, @rocky, @maximus]) 
    end
  end
end

  
