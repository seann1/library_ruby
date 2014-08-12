require 'spec_helper'

describe 'Book' do
  it 'creates a new book' do
    test_book = Book.new({:name => "new book"})
    expect(test_book).to be_a Book
  end

  describe 'initialize' do
    it 'returns the books name' do
      test_book = Book.new({:name => "The Jungle Book"})
      expect(test_book.name).to eq "The Jungle Book"
    end
  end

  describe 'save' do
    it 'saves a book to the database' do
      test_book = Book.new({:name => "The Jungle Book"})
      test_book.save
      expect(Book.all.length).to eq 1
    end
  end

  describe '.all' do
    it 'goes through all the books in the database' do
      test_book1 = Book.new({:name => "The Hobbit"})
      test_book2 = Book.new({:name => "The Jungle Book"})
      test_book1.save
      test_book2.save
      expect(Book.all).to eq [test_book1, test_book2]
    end
  end

  describe '.==' do
    it 'is the same book if it has the same name' do
      test_book1 = Book.new({:name => "The Hobbit"})
      test_book2 = Book.new({:name => "The Hobbit"})
      test_book1.save
      test_book2.save
      expect(test_book1).to eq test_book2
    end
  end

  describe "self.find" do
    it 'finds the book in the database specified by the user' do
      test_book1 = Book.new({:name => "The Hobbit"})
      test_book2 = Book.new({:name => "The Jungle Book"})
      test_book1.save
      test_book2.save
      expect(Book.find("The Hobbit")).to eq test_book1
    end
  end
end
