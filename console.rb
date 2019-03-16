require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Jack', 'funds' => 60})
customer1.save
customer2 = Customer.new({'name' => 'Ailsa', 'funds' => 25})
customer2.save
customer3 = Customer.new({'name' => 'Anna', 'funds' => 20})
customer3.save
customer4 = Customer.new({'name' => 'Dan', 'funds' => 50})
customer4.save
customer5 = Customer.new({'name' => 'Sally', 'funds' => 15})
customer5.save
customer6 = Customer.new({'name' => 'Sian', 'funds' => 40})
customer6.save
customer7 = Customer.new({'name' => 'Lucy', 'funds' => 40})
customer7.save
customer8 = Customer.new({'name' => 'Mads', 'funds' => 20})
customer8.save


film1 = Film.new({'title' => 'Captain Marvel', 'price' => 10})
film1.save
film2 = Film.new({'title' => 'Into the Spiderverse', 'price' => 7})
film2.save
film3 = Film.new({'title' => 'Lord of the Rings (Extended Edition Marathon)', 'price' => 30})
film3.save
film4 = Film.new({'title' => 'We Are The Best!', 'price' => '7'})
film4.save

screening1 = Screening.new({'time' => 1200, 'film_id' => film2.id})
screening2 = Screening.new({'time' => 1300, 'film_id' => film1.id})
screening3 = Screening.new({'time' => 1500, 'film_id' => film2.id})
screening4 = Screening.new({'time' => 1600, 'film_id' => film1.id})
screening5 = Screening.new({'time' => 2000, 'film_id' => film3.id})
screening6 = Screening.new({'time' => 1900, 'film_id' => film1.id})
screening7 = Screening.new({'time' => 2200, 'film_id' => film1.id})
screening8 = Screening.new({'time' => 1800, 'film_id' => film4.id})
screening1.save
screening2.save
screening3.save
screening4.save
screening5.save
screening6.save
screening7.save
screening8.save


ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening1.id})

ticket2 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening6.id})

ticket3 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening4.id})

ticket4 = Ticket.new({'customer_id' => customer4.id, 'screening_id' => screening5.id})

ticket5 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening5.id})

ticket6 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening6.id})

ticket7 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening3.id})

ticket8 = Ticket.new({'customer_id' => customer5.id, 'screening_id' => screening7.id})

ticket9 = Ticket.new({'customer_id' => customer6.id, 'screening_id' => screening7.id})

ticket10 = Ticket.new({'customer_id' => customer7.id, 'screening_id' => screening7.id})

ticket11 = Ticket.new({'customer_id' => customer8.id, 'screening_id' => screening8.id})



ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save
ticket7.save
ticket8.save
ticket9.save
ticket10.save
ticket11.save

binding.pry
nil
