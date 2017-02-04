class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
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
    sql = <<-SQL
    DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students(name, grade)
    VALUES (?, ?);
    SQL

    DB[:conn].execute(sql, @name, @grade)

    sql = <<-SQL
    SELECT last_insert_rowid() FROM students;
    SQL

    @id = DB[:conn].execute(sql)[0][0]
  end

  def self.create(name: name, grade: grade)
    new(name, grade).tap do |o|
      o.save
    end
  end

end
