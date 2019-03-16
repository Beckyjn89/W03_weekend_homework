require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id
  attr_accessor :time, :film_id

  def initialize(options)
    @time = options['time'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end

#create
  def save
    sql = "INSERT INTO screenings(time, film_id) VALUES ($1, $2) RETURNING id;"
    values = [@time, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

#read
  def self.all
    sql = "SELECT * FROM screenings"
    screening_data = SqlRunner.run(sql)
    return Screening.map_items(screening_data)
  end

#update
  def update
    sql = "UPDATE screenings SET (time, film_id) = ($1, $2)"
    values = [@time, @film_id]
    SqlRunner.run(sql, values)
  end

#delete
def delete
  sql = "DELETE FROM screenings WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

#delete all
def self.delete_all
  sql = "DELETE FROM screenings"
  SqlRunner.run(sql)
end

def customers
  sql = "SELECT * FROM screenings
  INNER JOIN tickets
  ON tickets.screening_id = screenings.id
  INNER JOIN customers
  ON tickets.customer_id = customers.id
  WHERE screenings.id = $1"
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  return Customer.map_items(customer_data)
end

#how many tickets screening has sold
  def tickets_num
    return self.customers.count
  end

#mapping
  def self.map_items(screening_data)
    return screening_data.map { |screening| Screening.new(screening) }
  end

  #top three screenings
  def self.top_three
    sql = "SELECT COUNT(tickets.screening_id) AS MOST_FREQUENT, screenings.*
    FROM tickets
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    GROUP BY tickets.screening_id, screenings.id
    ORDER BY COUNT(tickets.screening_id) DESC
    LIMIT 3"
    screening_data = SqlRunner.run(sql)
    return Screening.map_items(screening_data)
  end

end
