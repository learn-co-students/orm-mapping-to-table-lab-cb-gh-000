class Student

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table

    DB[:conn].execute("CREATE TABLE students (
                        id INTEGER PRIMARY KEY,
                        name TEXT,
                        grade TEXT);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?,?);", @name, @grade)
    @id = DB[:conn].execute("SELECT id FROM students WHERE name = ?
                                  AND grade = ?;", @name, @grade)[0][0]
  end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end

end
