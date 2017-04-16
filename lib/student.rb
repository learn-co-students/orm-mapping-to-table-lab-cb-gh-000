class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name;
    @grade = grade;
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
    SQL
    DB[:conn].execute(SQL)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXIST students";
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students(name, grade) VALUES(?, ?)"

    DB[:conn].execute(sql, @name, @grade)
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
end
