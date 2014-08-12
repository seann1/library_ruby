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
      books << Book.new({:name => result['name'], :id => result['name']})
    end
    books
  end
end
