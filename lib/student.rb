require 'pry'
require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade
  
  attr_reader :id
  
  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
    SQL
    DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql) 
  end
  
  def self.save(student_instance)
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, "#{student_instance.name}", "#{student_instance.grade}")

  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    Student.save(student)
  end

end
