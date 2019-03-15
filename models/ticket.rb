require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

#create
  def save
    sql = "INSERT INTO tickets(customer_id, screening_id) VALUES ($1, $2) RETURNING id;"
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

#read
  def self.all
    sql = "SELECT * FROM tickets"
    ticket_data = SqlRunner.run(sql)
    return Ticket.map_items(ticket_data)
  end

#update
def update
  sql = "UPDATE tickets SET (customer_id, screening_id) = ($1, $2)"
  values = [@customer_id, @screening_id]
  SqlRunner.run(sql, values)
end

#delete
def delete
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

#delete all
def self.delete_all
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

#mapping
  def self.map_items(ticket_data)
    return ticket_data.map { |ticket| Ticket.new(ticket) }
  end

end
