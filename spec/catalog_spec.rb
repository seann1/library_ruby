require 'spec_helper'

describe 'Catalog' do
  describe 'initialize' do
    it 'is initialized with a book id and author id' do
      test_book = Book.new({:id => 4 })
      test_author = Author.new({:id => 6})
      test_book.save
      test_author.save
      new_catalog = Catalog.new({:book_id => test_book.id, :author_id => test_author.id})
      expect(new_catalog.book_id).to eq new_catalog.book_id
    end
  end

  describe 'save' do
    it 'saves a book id and author id to the catalog table when a book is added' do
      test_book = Book.new({:name => "Jungle Book" })
      test_author = Author.new({:name => "Shakespeare"})
      test_book.save
      test_author.save
      new_catalog = Catalog.new({:book_id => test_book.id, :author_id => test_author.id})
      new_catalog.save
      expect(Catalog.all.length).to eq 1
    end
  end

  describe 'self.all' do
    it 'displays all entries in catalog table' do
      test_book = Book.new({:name => "Jungle Book" })
      test_author = Author.new({:name => "Shakespeare"})
      test_book.save
      test_author.save
      new_catalog = Catalog.new({:book_id => test_book.id, :author_id => test_author.id})
      new_catalog.save
      expect(Catalog.all.length).to eq 1
    end
  end

end

