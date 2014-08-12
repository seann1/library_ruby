require 'spec_helper'

describe 'Patron' do
  describe 'initialize' do
    it 'creates a new patron' do
      test_patron = Patron.new({:name => "bill"})
      expect(test_patron).to be_a Patron
    end

    it 'is initialized with a name' do
      test_patron = Patron.new({:name => 'bill'})
      expect(test_patron.name).to eq 'bill'
    end
  end

  describe 'save' do
    it 'saves a patron to the data base' do
      test_patron = Patron.new({:name => 'bill'})
      test_patron.save
      expect(Patron.all.length).to eq 1
    end
  end

  describe '.all' do
    it 'goes through all the patrons in the database' do
      test_patron1 = Patron.new({:name => 'bill'})
      test_patron2 = Patron.new({:name => 'frank'})
      test_patron1.save
      test_patron2.save
      expect(Patron.all).to eq [test_patron1, test_patron2]
    end
  end

  describe '.==' do
    it 'is the same patron if they have the same name' do
      test_patron1 = Patron.new({:name => 'bill'})
      test_patron2 = Patron.new({:name => 'bill'})
      test_patron1.save
      test_patron2.save
      expect(test_patron1).to eq test_patron2
    end
  end

  describe "self.find" do
    it "allows librarians to search for patrons by name" do
      test_patron1 = Patron.new({:name => "bill"})
      test_patron2 = Patron.new({:name => "sally"})
      test_patron1.save
      test_patron2.save
      expect(Patron.find("sally")).to eq test_patron2
    end
  end
end
