require 'set'

class Library
  attr_accessor :books

  def initialize
    @books = {}
  end

  def add_book(title, author)
    @books[title] = author
    puts "#{title} by #{author} has been added to the library."
  end

  def remove_book(title)
    if @books.delete(title)
      puts "#{title} has been removed from the library."
    else
      puts "#{title} was not found in the library."
    end
  end

  def search_by_title(title)
    if @books.key?(title)
      puts "Found: #{title} by #{@books[title]}"
    else
      puts "#{title} is not available in the library."
    end
  end

  def search_by_author(author)
    results = @books.select { |title, auth| auth == author }.keys
    if results.empty?
      puts "No books found by #{author}."
    else
      puts "Books by #{author}: #{results.join(', ')}"
    end
  end

  def list_all_books
    if @books.empty?
      puts "The library is currently empty."
    else
      puts "All books in the library:"
      @books.each { |title, author| puts "#{title} by #{author}" }
    end
  end
end

class LibraryUser
  attr_accessor :checked_out_books

  def initialize
    @checked_out_books = Set.new
  end

  def check_out_book(library, title)
    if library.books.key?(title) && !@checked_out_books.include?(title)
      @checked_out_books.add(title)
      library.remove_book(title)
      puts "You have checked out #{title}."
    else
      puts "#{title} is either not available or already checked out."
    end
  end

  def return_book(library, title)
    if @checked_out_books.delete?(title)
      library.add_book(title, library.books[title])
      puts "You have returned #{title}."
    else
      puts "You don't have #{title} checked out."
    end
  end

  def list_checked_out_books
    if @checked_out_books.empty?
      puts "You have no books checked out."
    else
      puts "Books you have checked out: #{@checked_out_books.to_a.join(', ')}"
    end
  end
end

def main
  library = Library.new
  user = LibraryUser.new

  loop do
    puts "\nLibrary System Menu"
    puts "1. Add Book"
    puts "2. Remove Book"
    puts "3. Search by Title"
    puts "4. Search by Author"
    puts "5. List All Books"
    puts "6. Check Out Book"
    puts "7. Return Book"
    puts "8. List Checked Out Books"
    puts "9. Exit"
    print "Choose an option: "

    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter book title: "
      title = gets.chomp
      print "Enter book author: "
      author = gets.chomp
      library.add_book(title, author)
    when 2
      print "Enter book title to remove: "
      title = gets.chomp
      library.remove_book(title)
    when 3
      print "Enter book title to search for: "
      title = gets.chomp
      library.search_by_title(title)
    when 4
      print "Enter author name to search for: "
      author = gets.chomp
      library.search_by_author(author)
    when 5
      library.list_all_books
    when 6
      print "Enter book title to check out: "
      title = gets.chomp
      user.check_out_book(library, title)
    when 7
      print "Enter book title to return: "
      title = gets.chomp
      user.return_book(library, title)
    when 8
      user.list_checked_out_books
    when 9
      puts "Goodbye!"
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end

main