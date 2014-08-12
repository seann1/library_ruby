class Book
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    books = []
    results = DB.exec("SELECT * FROM books;")
    results.each do |result|
      books << Book.new({:name => result['name'], :id => result['id'].to_i})
    end
    books
  end

  def ==(another_book)
    self.name == another_book.name
  end

  def self.find(name)
    Book.all.each do |book|
      if book.name == name
        @result = book
      end
    end
    @result
  end
end
