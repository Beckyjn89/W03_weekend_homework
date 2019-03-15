require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

#create
  def save
    sql = "INSERT INTO films(title, price) VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

#read
  def self.all
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

#update
  def update
    sql = "UPDATE films SET (title, price) = ($1, $2)"
    values = [@title, @price]
    SqlRunner.run(sql, values)
  end

#delete
def delete
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

#delete all
def self.delete_all
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

# def customers
#   sql = "SELECT * FROM films
#   INNER JOIN tickets
#   ON tickets.film_id = films.id
#   INNER JOIN customers
#   ON tickets.customer_id = customers.id
#   WHERE films.id = $1"
#   values = [@id]
#   customer_data = SqlRunner.run(sql, values)
#   return Customer.map_items(customer_data)
# end

#how many tickets film has sold
  # def tickets_num
  #   return self.customers.count
  # end

#mapping
  def self.map_items(film_data)
    return film_data.map { |film| Film.new(film) }
  end

end
