require 'pry'

class Catalog
  attr_reader :book_id, :author_id
  def initialize(attributes)
    @book_id = attributes[:book_id]
    @author_id = attributes[:author_id]
  end

  def save
    results = DB.exec("INSERT INTO catalog (book_id, author_id) VALUES ('#{@book_id}', '#{author_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    list =[]
    results = DB.exec("SELECT * FROM catalog;")
    results.each do |result|
      list << Catalog.new({:book_id => result['book_id'].to_i, :author_id => result['author_id'].to_i})
    end
    list
  end

  def ==(another_item)
    self.book_id == another_item.book_id && self.author_id == another_item.author_id
  end
end
