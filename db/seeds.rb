# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
Role.create(name: :admin)
Role.create(name: :client)
user1 = User.create!(email: 'admin@gmail.com',
                    password: 'password1234',
                    password_confirmation: 'password1234')
user1.add_role(:admin)
user2 = User.create!(email: 'client@gmail.com',
                    password: 'password1234',
                    password_confirmation: 'password1234')
user2.add_role(:user)
user3 = User.create!(email: 'operator@gmail.com',
                    password: 'password1234',
                    password_confirmation: 'password1234')
user3.add_role(:operator)
book1 = Book.create!("title" => 'Harry Potter 1', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 1", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
book2 = Book.create!("title" => 'Harry Potter 2', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 2", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
book3 = Book.create!("title" => 'Harry Potter 3', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 3", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
Book.create!("title" => 'Harry Potter 4', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 4", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
Book.create!("title" => 'Harry Potter 5', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 5", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
Book.create!("title" => 'Harry Potter 6', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 6", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
Book.create!("title" => 'Harry Potter 7', "author" => "JK", "publisher" => "Einaudi","overview" => "Overview 7", "isbn" => "1234567891", "updated_at"=> DateTime.now, "released_at" => 2005)
Reservation.create!("request_date" => DateTime.now, "isReturned" => false, "isLoan"=> false, "user_id"=>user1.id, "book_id"=>book1.id)