# Readbly  [![Build Status](https://travis-ci.org/LithiumSR/readbly.svg?branch=master)](https://travis-ci.org/LithiumSR/readbly)

Readbly is a prototype of library management system developed as part of the final exam of the lassi (Laboratorio di Applicazioni Software e Sicurezza Informatica) lab at Sapienza University.
This project is developed in Ruby using the Rails framework (5.2.0).

## Features

Readbly comes with support for 3 types of user:
- (Basic) user
- Operator
- Admin

The basic user is able to:
- Place a reservation
- View the books collection
- Delete his own pending reservations 
- Manage his account
- Postpone his own active reservations up to 1 time

The operator is able to:
- Do all the things that a normal user can do
- Create new books
- Edit books
- Confirm pending reservations
- Confirm the return of a loan
- Delete the pending reservations of another user
- Postpone the active reservations (loans) of another user up to 3 times

The admin is able to:
- Do all the things that an operator can do
- Manage the users
- Delete books
- Delete reservations/loans
- Postpone active reservations (loans) an infinite number of times

## How to setup 

1.  ``git clone`` this repo 
2.  Open the terminal in the project path and use `bundle install`
3. Setup the database.yml with your credentials and use `rails db:migrate` and `rails db:seed`
4. Start the server with `rails server`
5. Login using the default accounts:
	- email: "admin@readbly.test" , password : "password1234"
	-  email: "operator@readbly.test" , password : "password1234"
	-  email: "user@readbly.test" , password : "password1234"
