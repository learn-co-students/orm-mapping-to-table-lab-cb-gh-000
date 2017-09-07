class Student
  attr_accessor :name,:grade
  attr_reader :id

  def initialize(name,grade,id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    query = <<-SQL
      CREATE TABLE students(
        id integer primary key,
        name text,
        grade text
      )
    SQL
    DB[:conn].execute(query)
  end

  def self.drop_table
    query = <<-SQL
      DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(query)
  end

  def save
    query = <<-SQL
      INSERT INTO students(name,grade) values (?,?)
    SQL
    DB[:conn].execute(query,@name,@grade)
    @id = DB[:conn].execute("select id from students where name=? and grade=?",@name,@grade).flatten[0]
  end

  def self.create(args)
    s = Student.new(args[:name],args[:grade])
    s.save
    s
  end

end
