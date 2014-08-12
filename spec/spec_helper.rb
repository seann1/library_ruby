require 'pg'
require 'rspec'
require './lib/authors'
require './lib/checkouts'
require './lib/catalog'
require './lib/patrons'
require './lib/books'
DB = PG.connect(:dbname => 'library_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    # DB.exec("DELETE FROM checkouts *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM catalog *;")
  end
end
