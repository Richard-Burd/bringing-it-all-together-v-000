class Dog
  attr_accessor :id, :name, :breed

  def initialize(id: nil, name:, breed:)
    self.id = id
    self.name = name
    self.breed = breed
  end

  def self.create_table
    table_creating_sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL

    DB[:conn].execute(table_creating_sql)
  end

  def self.drop_table
    table_destroying_sql = <<-SQL
      DROP TABLE IF EXISTS dogs
    SQL

    DB[:conn].execute(table_destroying_sql)
  end

  def update
    sql_update = <<-SQL
      UPDATE dogs SET name = ?, breed = ? WHERE id = ?
    SQL
    DB[:conn].execute(sql_update, self.name, self.breed, self.id)
  end

  def save
    # This method requires the <<self.update>> in order to work.
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end

  def self.create # this only creates the Ruby object, not the database entry
    dog = Dog.new(name: name, breed: breed)
    dog.save
    dog
  end

  def self.find_or_create_by
    # This method requires the <<self.create>> method
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    breed = breed[2]
    self.new(id: id, name: name, breed: breed)
  end

  def self.find_by_name(name)

  end

  def self.find_by_id(id)
    sql_finder = <<-SQL
      SELECT * FROM dogs WHERE id = ? LIMIT 1
    SQL

    DB[:conn].execute(sql_finder, id).map do |series|
      self.new_from_db(series)
    end.first
  end
end
