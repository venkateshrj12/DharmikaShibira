class ChangeDateTypeInStudents < ActiveRecord::Migration[7.0]
  def change
    change_column :students, :date_of_birth, :date
  end
end
