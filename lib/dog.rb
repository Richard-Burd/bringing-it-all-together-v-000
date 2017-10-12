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

  end

  def save
    # This method requires the <<self.update>> in order to work.

  end

  def self.create # this only creates the Ruby object, not the database entry

  end

  def self.find_or_create_by
    # This method requires the <<self.create>> method
  end

  def self.new_from_db(row)

  end

  def self.find_by_name(name)

  end

  def self.find_by_id(id)

  end
end
