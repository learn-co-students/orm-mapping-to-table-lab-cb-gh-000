require "spec_helper"

describe "Student" do
  let(:josh) {Student.new("Josh", "9th")}

  before(:each) do
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  describe "when initialized with a name and a grade" do
    it 'the name attribute can be accessed' do
      student = Student.new("Tiffany", "11th")
      expect(student.name).to eq("Tiffany")
    end

    it 'the grade attribute can be accessed' do
      student = Student.new("Tiffany", "11th")
      expect(student.grade).to eq("11th")
    end
  end

  it 'responds to a getter for :id' do
    expect(josh).to respond_to(:id)
  end

  it 'does not provide a setter for :id' do
    expect{josh.id = 1}.to raise_error(NoMethodError)
  end

  describe ".create_table" do
    it 'creates the students table in the database' do
      Student.create_table
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='students';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(['students'])
    end
  end

  describe ".drop_table" do
    it 'drops the students table from the database' do
      Student.create_table
      Student.drop_table
      table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='students';"
      expect(DB[:conn].execute(table_check_sql)[0]).to eq(nil)
    end
  end

  describe "#save" do
    it 'saves an instance of the Student class to the database' do
      Student.create_table
      josh.save
      expect(josh.id).to eq(1)
      expect(DB[:conn].execute("SELECT * FROM students")).to eq([[1, "Josh", "9th"]])
    end
  end

  describe ".create" do
    before(:each) do
      Student.create_table
    end
    it 'takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database' do
      Student.create(name: "Sally", grade: "10th")
      expect(DB[:conn].execute("SELECT * FROM students")).to eq([[1, "Sally", "10th"]])
    end
    it 'returns the new object that it instantiated' do
      student = Student.create(name: "Josh", grade: "9th")
      expect(student).to be_a(Student)
      expect(student.name).to eq("Josh")
      expect(student.grade).to eq("9th")
    end
  end
end
