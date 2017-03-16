class Student
  attr_accessor :grade, :name
  attr_reader :id

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save

    student
  end

  def self.create_table
    sql =
      <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255),
        grade VARCHAR(255)
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def initialize(name, grade)
    @grade = grade
    @name = name
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
end
