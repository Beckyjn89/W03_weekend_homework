require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Jack', 'funds' => 30})
customer1.save
customer2 = Customer.new({'name' => 'Ailsa', 'funds' => 20})
customer2.save
customer3 = Customer.new({'name' => 'Anna', 'funds' => 20})
customer3.save
customer4 = Customer.new({'name' => 'Dan', 'funds' => 50})
customer4.save

film1 = Film.new({'title' => 'Captain Marvel', 'price' => 10})
film1.save
film2 = Film.new({'title' => 'Spiderman Into the Spiderverse', 'price' => 7})
film2.save
film3 = Film.new({'title' => 'Lord of the Rings (Extended Edition Marathon)', 'price' => 30})
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film3.id})
ticket4.save






binding.pry
nil
