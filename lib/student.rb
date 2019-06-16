class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql,[name, grade])
    @id = DB[:conn].execute("SELECT last_insert_rowid()")[0][0]
  end

  def self.create(attributes)
    student = self.new(attributes[:name], attributes[:grade])
    student.save
    student
  end

  def self.create_table
    sql = "CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
    )"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end



end
