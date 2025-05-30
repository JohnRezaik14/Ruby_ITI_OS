class Book
    # Each book has title, auther and ISBN
    # count for book class
    @@count=0
    attr_accessor :title
    attr_accessor :auther
    attr_accessor :isbn

    def initialize(title,auther,isbn)
        @title=title
        @auther=auther
        @isbn=isbn
        @@count+=1
    end 

    def to_string()
        return "Book:- title: #{title}, auther: #{auther},ISBN: #{isbn} "
    end
    def self.getCount()
        puts "Count of books: #{@@count}"
    end
end
# end of class Book

class Inventory
    attr_accessor :file
    attr_reader :count 
    attr_accessor :state
    attr_reader :books
    def initialize(file="inventory.txt")
        @state=true
        @file=file
        @books={}
        # puts @file
    end
# -------------lisiting books------------------------
    def list_books
        puts "Listing Books \n"
        begin
            f= File.new(@file,'r')
            # puts f
        rescue 
            puts "Can't open the file"
            puts "file : #{@file}"
        else
            # puts f
            
            if @books.count==0
                # puts "file arr empty"
                   f.each_line do |line|
                    book=line.split(':').to_a
                    puts "Book Title: "+ book[1]+ ", auther: "+ book[2]+", ISBN: "+ book[0]
                    puts '----------------------------------------------------------------------------------------------------------'
                    end
            else
                # puts "file arr not empty"
                for book in @books
                    puts "Book: #{book.title}"
                end
            end
        ensure
        
            if f
                f.close 
            end
        end
    
        run
    end
# -------------adding book------------------------

    def add_book
        puts "adding book"
        begin
            f= File.new(@file,'a+')
            # puts f
        rescue
            puts "Can't open the file"
            puts "file : #{@file}"
        else
            puts "enter the title of the book"
            title = gets.chomp
            puts "enter the auther of the book"
            auther = gets.chomp
            puts "enter the ISBN of the book"
            isbn = gets.chomp
            book=Book.new(title,auther,isbn)
            # line_count = f ? f.count+1 : 0
            # puts line_count+1
            # @books[isbn]=[book,line_count+1]
            # f.puts(book)
            f.puts("#{book.isbn}:#{book.title}:#{book.auther}") 
        ensure
             if f
                f.close 
            end
        end
        run

    end
# -------------removing book------------------------

    def remove_book(isbn)
        # puts @books[isbn]
        # puts @books
        begin
            lines = []
            File.open(@file, 'r') do |f|
            lines = f.readlines
            end

            new_lines = lines.reject do |line|
            book = line.split(':')
            book[0].strip == isbn.to_s.strip
            end

            File.open(@file, 'w') do |f|
            new_lines.each { |line| f.puts(line.chomp) }
            end

            puts "Book with ISBN #{isbn} removed."
            
            rescue
            puts "Can't open the file"
            puts "file : #{@file}"  
        end
        run

    end
# -------------running inventory menu------------------------
    def run
        system("clear")
        puts "----------------------Choose from the menu----------------------"
        puts "1:List Books"
        puts "2:Add new Book"
        puts "3:Remove Book by ISBN"
        puts "3:to quit enter 'q'"
        input = gets.chomp.to_s
        # puts input
        if input == "q"
            puts("You chose to close")
            exit(0)
        else
            input=input.to_i
        end
        
        case input
        when 1
            puts "choosed to list books"
            list_books
        when 2
            puts "choosed to add a book"
            add_book
        when 3
            puts "choosed to remove book"
            puts "enter the ISBN of Book"
            isbn=gets.chomp.to_i
            remove_book(isbn)
        else
            puts "not found choose again"
            run
        end
    end
    # end of class inventory
end

BEGIN{
    puts "starting the program"
}

# book1 = Book.new("intro to programming","John",12345678900)
# book1 = Book.new("intro to programming","John",12345678900)
# book1.to_string
# Book.getCount
inventory =Inventory.new("inv.txt")
inventory.run
END{
    "ending the program"
}