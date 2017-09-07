class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

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

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end

  def self.create name: name, grade: grade
    student = Student.new(name, grade)
    student.save
    student
  end

  attr_accessor :name,:grade
  attr_reader :id

  def initialize name, grade
      @id = nil
      @name = name
      @grade = grade
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name,grade)
      VALUES (?,?)
      SQL
    DB[:conn].execute(sql,self.name,self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

end
