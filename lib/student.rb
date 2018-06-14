class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id 
  
  def initialize( name, grade)
    @name = name 
    @grade = grade 
    @id = nil
  end 
  
  def self.create_table 
    sql =   <<-SQL 
                CREATE TABLE IF NOT EXISTS students (
                id INTEGER PRIMARY KEY,
                name TEXT,
                grade TEXT
                )
                SQL
                
    DB[:conn].execute(sql)      
  end 
  
  
  # def self.create_table
  #   sql =  <<-SQL 
  #     CREATE TABLE IF NOT EXISTS songs (
  #       id INTEGER PRIMARY KEY, 
  #       name TEXT, 
  #       album TEXT
  #       )
  #       SQL
  #   DB[:conn].execute(sql) 
  # end
  
  
  def self.drop_table 
    
    sql = <<-SQL
              DROP TABLE IF EXISTS students
              SQL
            
    DB[:conn].execute(sql)
    
  end 
  
  def save 
      
    sql = <<-SQL 
              INSERT INTO students (name, grade) VALUES ( ?, ? )
              SQL
          
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end 
  
  def self.create(name:, grade:)
    
    new = self.new( name, grade)
    new.save
    new 
      
  end   

  
end


