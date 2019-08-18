class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?);
      SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")[0][0]
  end

  def self.create(name:, grade:)
    obj = Student.new(name, grade)
    obj.save
    obj
  end
end
