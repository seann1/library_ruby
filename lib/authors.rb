require 'pry'
class Author
  attr_accessor :name, :id

  def initialize(attributes)
    @name =attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    authors =[]
    results = DB.exec("SELECT * FROM authors;")
    results.each do |result|
      authors << Author.new({:name => result['name'], :id => result['id'].to_i})
    end
    authors
  end

  def ==(another_author)
    self.name == another_author.name
  end

  def self.find(name)
    Author.all.each do |author|
      if author.name == name
        @result = author
      end
    end
    @result
  end

  def books
    names_array = []
    author_name = DB.exec("SELECT * FROM authors WHERE name = '#{self.name}';")
    results = DB.exec("SELECT * FROM
              authors JOIN catalog ON (authors.id = catalog.author_id)
              JOIN books ON (catalog.book_id = books.id)
              WHERE authors.id = '#{self.id}';")
    results.each do |result|
      names_array << Book.new({:name => result['name'], :id => result['book_id']})
    end
    names_array
  end
end


