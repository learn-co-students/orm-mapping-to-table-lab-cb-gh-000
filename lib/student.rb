class Student
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  # Creates students table in the database
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL

    DB[:conn].execute(sql)
  end

  # Drops students table from the database
  def self.drop_table

  end

  # Creates a new Student object from a hash of attributes
  # and saves the student to the database
  def self.create
    # takes in a hash of attributes
    # uses metaprogramming to create new student object
    # uses #save method to save student to db
    # returns new object that it instantiated
  end

  # Saves an instance of the Student class to the database
  def save

  end
  
end
