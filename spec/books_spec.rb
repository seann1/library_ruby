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
end
