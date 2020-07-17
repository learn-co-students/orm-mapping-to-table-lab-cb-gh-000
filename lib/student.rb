class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :id

  attr_accessor :name,:grade
  def initialize(name,grade,id=nil)
    @name=name
    @grade=grade
    @id=id
  end

  def self.create_table()
    sql="CREATE TABLE students(
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
    );"

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql="DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql="INSERT INTO students(name,grade) VALUES(?,?)"
    DB[:conn].execute(sql,@name,@grade)
    sql1="SELECT id FROM students ORDER BY id DESC LIMIT 1"
    arr=DB[:conn].execute(sql1)
    @id=arr[0][0]
  end

  def self.create (name:,grade:)
    s=Student.new(name,grade)
    s.save
    return s
  end

end
