require 'pg'
require './lib/authors'
require './lib/checkouts'
require './lib/catalog'
require './lib/patrons'
require './lib/books'

DB = PG.connect({:dbname => 'library_test'})

def main_menu
  puts "Press 1 if you are a librarian"
  puts "Press 2 if you are a patron"
  puts "Press x to exit"
  answer = gets.chomp

  if answer == '1'
    librarian_menu
  elsif answer == '2'
    patron_menu
  elsif answer == '3'
    exit
  else
    puts "You entered an invalid choice"
  end
end

def librarian_menu
  puts "Press 1 to add a book"
  puts "Press 2 to list all books and authors"
  puts "Press 3 to list all books by an author"
  puts "Press x to return to main menu"
  answer = gets.chomp

  if answer == '1'
    add_book
  elsif answer == '2'
    list_catalog
  elsif answer == '3'
    books_for_author
  elsif answer == 'x'
    puts "Goodbye"
    main_menu
  else
    puts "Invalid choice"
    librarian_menu
  end
end

def add_book
  puts "Enter book title"
  book_name = gets.chomp
  puts "Enter author name"
  author_name = gets.chomp
  new_book = Book.new({:name => book_name})
  new_author = Author.new({:name => author_name})
  new_book.save
  new_author.save
  author_list = Author.all
    author_list.each do |author|
      if author.name == author_name
        author_id = author.id
        new_entry = Catalog.new({:book_id => new_book.id, :author_id => author_id})
        new_entry.save
      else
        new_entry = Catalog.new({:book_id => new_book.id, :author_id => new_author.id})
        new_entry.save
      end
    end
    librarian_menu
  end

  def list_catalog
    Author.books


    # results = DB.exec("SELECT authors.* FROM
    #           authors JOIN catalog ON (authors.id = catalog.author_id)
    #           JOIN books ON (catalog.book_id = books.id);")
    # results.each do |result|
    #   puts result['name']
    # end
  end

  def books_for_author
    puts "Enter author name"
    author = gets.chomp
    found_author = Author.find(author)
    found_author.books

  end


  main_menu
