class AddStudentContactNumberToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :student_contact_number, :string
  end
end
