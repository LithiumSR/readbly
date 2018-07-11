require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "Create book without an ISBN" do
  it "shouldn't be permitted" do
    book = Book.new(:title => 'Harry Potter 1', :released_at => 2010, :overview => 'Long long time ago...', :author => 'Rowling', :publisher => "Mondadori")
    expect(book).not_to be_valid
  end
  end

  describe "Create a book with an invalid ISBN" do
    it "shouldn't be permitted" do
    book = Book.new(:title => 'Harry Potter 1', :released_at => 2010, :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "123", :publisher => "Mondadori")
    expect(book).not_to be_valid
  end
  end

  describe "Create a book with a negative release date" do
  it "shouldn't be permitted" do
    book = Book.new(:title => 'Harry Potter 1', :released_at => -1, :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", :publisher => "Mondadori")
    expect(book).not_to be_valid
  end
  end

  describe "Create a book without a title" do
    it "shouldn't be permitted" do
      book = Book.new(:released_at => 2000, :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", :publisher => "Mondadori")
      expect(book).not_to be_valid
    end
  end

  book = Book.new(:title => "Harry Potter 1", :released_at => 2000, :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", :publisher => "Mondadori")
  describe "Create a book without an overview" do
    it "shouldn't be permitted" do
      book = Book.new(:title => "Harry Potter 1", :released_at => 2000, :author => 'Rowling', :isbn => "0439708184", :publisher => "Mondadori")
      expect(book).not_to be_valid
    end
  end

  describe "Create a book without an author" do
    it "shouldn't be permitted" do
      book = Book.new(:title => "Harry Potter 1", :released_at => 2000, :overview => 'Long long time ago...', :isbn => "0439708184", :publisher => "Mondadori")
      expect(book).not_to be_valid
    end
  end

  describe "Create a book without a year of release" do
    it "shouldn't be permitted" do
      book = Book.new(:title => "Harry Potter 1", :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", :publisher => "Mondadori")
      expect(book).not_to be_valid
    end
  end

  describe "Create a book without a publisher" do
    it "shouldn't be permitted" do
      book = Book.new(:title => "Harry Potter 1", :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", :released_at => "2010")
      expect(book).not_to be_valid
    end
  end

  describe "Create two book with the same isbn and add them to the database" do
    it "should be permitted" do
      expect{
        Book.create!(:title => "Harry Potter 1", :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", released_at: 2000, :publisher => "Mondadori")
        Book.create!(:title => "Harry Potter 1", :overview => 'Long long time ago...', :author => 'Rowling', :isbn => "0439708184", released_at: 2000, :publisher => "Mondadori")
             }.to_not raise_error
    end
  end
end
