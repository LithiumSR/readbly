json.extract! book, :id, :title, :author, :publisher, :overview, :isbn, :created_at, :released_at, :coverlink, :created_at, :updated_at
json.url book_url(book, format: :json)
