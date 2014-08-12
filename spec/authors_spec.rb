require 'spec_helper'

describe 'Author' do
  describe 'initialize' do
    it 'creates a new author' do
      test_author = Author.new({:name => "mark twain"})
      expect(test_author).to be_an Author
    end

    it 'gives an author a name' do
      test_author = Author.new({:name => "mark twain"})
      expect(test_author.name).to eq "mark twain"
    end
  end

  describe 'save' do
    it 'saves an author to the database' do
      test_author = Author.new({:name => "mark twain"})
      test_author.save
      expect(Author.all.length).to eq 1
    end
  end

  describe 'self.all' do
    it 'retrieves all authors from the database' do
      test_author1 = Author.new({:name => "mark twain"})
      test_author2 = Author.new({:name => "herman melville"})
      test_author1.save
      test_author2.save
      expect(Author.all).to eq [test_author1, test_author2]
    end
  end

  describe '.==' do
    it 'makes two objects with the same name equal' do
      test_author1 = Author.new({:name => "mark twain"})
      test_author2 = Author.new({:name => "mark twain"})
      test_author1.save
      test_author2.save
      expect(test_author1).to eq test_author2
    end
  end

  describe 'self.find' do
    it 'finds the author in the database specified by the user' do
      test_author1 = Author.new({:name => "mark twain"})
      test_author2 = Author.new({:name => "herman melville"})
      test_author1.save
      test_author2.save
      expect(Author.find("mark twain")).to eq test_author1
    end
  end

  describe 'books' do
    it 'returns all books associated with the author' do
      test_author1 = Author.new({:name => "mark twain"})
      test_book1 = Book.new({:name => "The Hobbit"})
      test_book2 = Book.new({:name => "The Jungle Book"})
      test_author1.save
      test_book1.save
      test_book2.save
      new_catalog = Catalog.new({:book_id => test_book1.id, :author_id => test_author1.id})
      new_catalog.save
      new_catalog2 = Catalog.new({:book_id => test_book2.id, :author_id => test_author1.id})
      new_catalog2.save
      expect(test_author1.books).to eq [test_book1, test_book2]
    end
  end
end
