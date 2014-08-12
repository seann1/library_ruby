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

end


