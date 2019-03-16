require_relative('../db/sql_runner.rb')
require_relative('./screening.rb')

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

#see all screenings for a particular film
def all_screenings
  sql = "SELECT * FROM films
        INNER JOIN screenings
        ON screenings.film_id = films.id
        WHERE films.id = $1"
  values = [@id]
  screening_data = SqlRunner.run(sql, values)
  return Screening.map_items(screening_data)
end

def total_customers
  sql = "SELECT COUNT (tickets.id) AS sales_count FROM films
  INNER JOIN screenings
  ON screenings.film_id = films.id
  INNER JOIN tickets
  ON tickets.screening_id = screenings.id
  WHERE films.id = $1"
  values = [@id]
  tot_custs = SqlRunner.run(sql, values)
  return tot_custs.first['sales_count'].to_i
end

#most popular screening
def most_pop_screening
  sql = "SELECT COUNT(tickets.screening_id) AS MOST_FREQUENT, screenings.*
  FROM tickets
  INNER JOIN screenings
  ON tickets.screening_id = screenings.id
  WHERE screenings.film_id = $1
  GROUP BY tickets.screening_id, screenings.id
  ORDER BY COUNT(tickets.screening_id) DESC
  LIMIT 1"
  values = [@id]
  all_screenings_freq = SqlRunner.run(sql, values)
  screening_data = all_screenings_freq
  return Screening.map_items(screening_data)
end

#top three films
def self.top_three
    sql = "SELECT COUNT(tickets.*) AS MOST_FREQUENT, films.*
    FROM tickets
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    INNER JOIN films
    ON screenings.film_id = films.id
    GROUP BY screenings.film_id, films.id
    ORDER BY COUNT(tickets.screening_id) DESC
    LIMIT 3"
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

#mapping
  def self.map_items(film_data)
    return film_data.map { |film| Film.new(film) }
  end

end
