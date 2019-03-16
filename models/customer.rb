require_relative('../db/sql_runner.rb')
require_relative('./screening.rb')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

#create
  def save
    sql = "INSERT INTO customers(name, funds) VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

#read
  def self.all
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

#update
def update
  sql = "UPDATE customers SET (name, funds) = ($1, $2)"
  values = [@name, @funds]
  SqlRunner.run(sql, values)
end

#delete
def delete
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

#delete all?
def self.delete_all
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

#all screenings a customer has tickets to see
def tickets
  sql = "SELECT * FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  INNER JOIN screenings
  ON tickets.screening_id = screenings.id
  INNER JOIN films
  ON screenings.film_id = films.id
  WHERE customers.id = $1"
  values = [@id]
  screening_data = SqlRunner.run(sql, values)
  return Screening.map_items(screening_data)
end

#remove ticket price from customer funds
def remaining_funds
  sql = "SELECT films.price AS money_spent FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  INNER JOIN screenings
  ON tickets.screening_id = screenings.id
  INNER JOIN films
  ON screenings.film_id = films.id
  WHERE customers.id = $1"
  values = [@id]
  spending = SqlRunner.run(sql, values)
  spending_arr = spending.map{|spending| spending['money_spent'].to_i }
  @funds -= spending_arr.sum
end

#how many tickets customer has
  def tickets_num
    return self.films.count
  end

#mapping
  def self.map_items(customer_data)
    return customer_data.map { |customer| Customer.new(customer) }
  end

end
