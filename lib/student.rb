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
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  # Creates a new Student object from a hash of attributes
  # and saves the student to the database
  def self.create(attributes)
    name = attributes[:name]
    grade = attributes[:grade]

    student = self.new(name, grade)

    attributes.each do |attribute, value|
      student.send("#{attribute}=", value)
    end

    student.save
    student
  end

  # Saves an instance of the Student class to the database
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute('SELECT last_insert_rowid() FROM students')[0][0]
    self
  end
end
