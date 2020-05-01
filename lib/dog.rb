require 'pry'
class Dog
  attr_accessor :name, :id
  attr_reader :breed
  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end
  def self.create_table
    sql =<<-SQL
    CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, breed TEXT);
    SQL
    DB[:conn].execute(sql)
  end
  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end
  def save
    if
      self.id
      self.update
    sql = <<-SQL
    INSERT INTO dogs(name, breed) VALUES(?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid()FROM dogs;")[0][0]
  end
end
  def self.create(name:, breed:)
    dog = Dog.new(name,breed)
    dog.save
    dog
  end
def self.new_from_db(row)
  id = row[0]
  name = row[1]
  breed = row[2]
  dog= self.new(id, name, breed)
  dog
end
def update
   sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
   DB[:conn].execute(sql, self.name, self.breed, self.id)
 end
end
