class Patron
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    patrons = []
    results = DB.exec("SELECT * FROM patrons;")
    results.each do |result|
      patrons << Patron.new({:name => result['name'], :id => result['id'].to_i})
    end
    patrons
  end

  def ==(another_patron)
    self.name == another_patron.name
  end

  def self.find(name)
    Patron.all.each do |patron|
      if patron.name = name
        @result = patron
      end
    end
    @result
  end
end
