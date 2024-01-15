class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.datetime :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
