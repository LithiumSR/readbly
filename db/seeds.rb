# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(name: :admin)
Role.create(name: :user)
Role.create(name: :operator)
Reservation.delete_all
User.delete_all
Book.delete_all
user1 = User.create!(email: 'admin@readbly.test',
                    password: 'password1234',
                    password_confirmation: 'password1234')
user1.remove_role(:user)
user1.add_role(:admin)
user2 = User.create!(email: 'client@readbly.test',
                    password: 'password1234',
                    password_confirmation: 'password1234')
user2.add_role(:user)
user3 = User.create!(email: 'operator@readbly.test',
                    password: 'password1234',
                    password_confirmation: 'password1234')
user3.remove_role(:user)
user3.add_role(:operator)
Book.create!([
                 {title: "Harry Potter and the Goblet of Fire", author: "J. K. Rowling", publisher: "Bloomsbury Publishing", overview: "The Triwizard Tournament is to be held at Hogwarts. Only wizards who are over seventeen are allowed to enter - but that doesn't stop Harry dreaming that he will win the competition. Then at Hallowe'en, when the Goblet of Fire makes its selection, Harry is amazed to find his name is one of those that the magical cup picks out. He will face death-defying tasks, dragons and Dark wizards, but with the help of his best friends, Ron and Hermione, he might just make it through - alive! These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. It's time to PASS THE MAGIC ON .", isbn: "9781408855683", coverlink: "https://books.google.com/books/content?id=_pjHBAAAQBAJ&printsec=frontcover&img=1&zoom=0&source=gbs_api", released_at: 2014, isDisabled: false},
                 {title: "Harry Potter and the Deathly Hallows (Book 7)", author: "Rowling, J.K.", publisher: "Pottermore", overview: "In Harry Potter and the Deathly Hallows, the seventh and final book in the epic tale of Harry Potter, Harry and Lord Voldemort each prepare for their ultimate encounter. Voldemort takes control of the Ministry of Magic, installs Severus Snape as headmaster at Hogwarts, and sends his Death Eaters across the country to wreak havoc and find Harry. Meanwhile, Harry, Ron, and Hermione embark on a desperate quest the length and breadth of Britain, trying to locate and destroy Voldemort’s four remaining Horcruxes, the magical objects in which he has hidden parts of his broken soul. They visit the Burrow, Grimmauld Place, the Ministry, Godric’s Hollow, Malfoy Manor, Diagon Alley…But every time they solve one mystery, three more evolve—and not just about Voldemort, but about Dumbledore, and Harry’s own past, and three mysterious objects called the Deathly Hallows. The Hallows are literally things out of a children’s tale, which, if real, promise to make their possessor the “Master of Death;” and they ensnare Harry with their tantalizing claim of invulnerability. It is only after a nigh-unbearable loss that he is brought back to his true purpose, and the trio returns to Hogwarts for the final breathtaking battle between the forces of good and evil. They fight the Death Eaters alongside members of the Order of the Phoenix, Dumbledore’s Army, the Weasley clan, and the full array of Hogwarts teachers and students. Yet everything turns upon the moment the entire series has been building up to, the same meeting with which our story began: the moment when Harry and Voldemort face each other at last.", isbn: "9780545010221", coverlink: "https://books.google.com/books/content?id=H8sdBgAAQBAJ&printsec=frontcover&img=1&zoom=0&source=gbs_api", released_at: 2015, isDisabled: false},
                 {title: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", publisher: "Pottermore", overview: "\"Turning the envelope over, his hand trembling, Harry saw a purple wax seal bearing a coat of arms; a lion, an eagle, a badger and a snake surrounding a large letter 'H'.\" Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harry's eleventh birthday, a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: Harry Potter is a wizard, and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!", isbn: "9781781100219", coverlink: "https://books.google.com/books/content?id=39iYWTb6n6cC&printsec=frontcover&img=1&zoom=0&edge=curl&source=gbs_api", released_at: 2015, isDisabled: false},
                 {title: "Harry Potter and the Chamber of Secrets", author: "J.K. Rowling", publisher: "Pottermore", overview: "\"'There is a plot, Harry Potter. A plot to make most terrible things happen at Hogwarts School of Witchcraft and Wizardry this year.'\" Harry Potter's summer has included the worst birthday ever, doomy warnings from a house-elf called Dobby, and rescue from the Dursleys by his friend Ron Weasley in a magical flying car! Back at Hogwarts School of Witchcraft and Wizardry for his second year, Harry hears strange whispers echo through empty corridors - and then the attacks start. Students are found as though turned to stone... Dobby's sinister predictions seem to be coming true.", isbn: "9781781100226", coverlink: "https://books.google.com/books/content?id=1o7D0m_osFEC&printsec=frontcover&img=1&zoom=0&edge=curl&source=gbs_api", released_at: 2015, isDisabled: false},
                 {title: "Harry Potter and the Prisoner of Azkaban", author: "J.K. Rowling", publisher: "Pottermore", overview: "\"'Welcome to the Knight Bus, emergency transport for the stranded witch or wizard. Just stick out your wand hand, step on board and we can take you anywhere you want to go.'\" When the Knight Bus crashes through the darkness and screeches to a halt in front of him, it's the start of another far from ordinary year at Hogwarts for Harry Potter. Sirius Black, escaped mass-murderer and follower of Lord Voldemort, is on the run - and they say he is coming after Harry. In his first ever Divination class, Professor Trelawney sees an omen of death in Harry's tea leaves... But perhaps most terrifying of all are the Dementors patrolling the school grounds, with their soul-sucking kiss...", isbn: "9781781100233", coverlink: "https://books.google.com/books/content?id=wHlDzHnt6x0C&printsec=frontcover&img=1&zoom=0&edge=curl&source=gbs_api", released_at: 2015, isDisabled: false},
                 {title: "Harry Potter and the Half-Blood Prince", author: "J. K. Rowling", publisher: "Bloomsbury Publishing", overview: "When Dumbledore arrives at Privet Drive one summer night to collect Harry Potter, his wand hand is blackened and shrivelled, but he does not reveal why. Secrets and suspicion are spreading through the wizarding world, and Hogwarts itself is not safe. Harry is convinced that Malfoy bears the Dark Mark: there is a Death Eater amongst them. Harry will need powerful magic and true friends as he explores Voldemort's darkest secrets, and Dumbledore prepares him to face his destiny. These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. It's time to PASS THE MAGIC ON .", isbn: "9781408855706", coverlink: "https://books.google.com/books/content?id=bZnHBAAAQBAJ&printsec=frontcover&img=1&zoom=0&source=gbs_api", released_at: 2014, isDisabled: false}
             ])
book1 = Book.find_by_isbn(9781781100226)
book2 = Book.find_by_isbn(9781408855683)
book3 = Book.find_by_isbn(9781408855706)
Reservation.create!([
                        {request_date: DateTime.now, expiration_date: nil, isReturned: false, isLoan: false, user_id: user2.id, book_id: book1.id, isPostponed: false, return_date: nil, postpone_counter: 0},
                        {request_date: "2018-07-21", expiration_date: nil, isReturned: false, isLoan: false, user_id: user2.id, book_id: book2.id, isPostponed: false, return_date: nil, postpone_counter: 1},
                        {request_date: DateTime.now - 15.day, expiration_date: DateTime.now - 15.day, isReturned: false, isLoan: true, user_id: user2.id, book_id: book3.id, isPostponed: true, return_date: nil, postpone_counter: 2}
                    ])
res2 = Reservation.find_by(:user_id => user2.id, :book_id => book2.id)
res2.isReturned = true
res2.isLoan = true
res2.expiration_date = res2.request_date + 1.month
res2.return_date = res2.request_date + 15.day
res2.save
res3 = Reservation.find_by(:user_id => user2.id, :book_id => book3.id)
res3.isLoan = true
res3.expiration_date = res3.request_date + 1.month
res3.save