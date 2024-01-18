class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.date :date_of_birth
      t.integer :gender
      t.string :type
      t.string :parent_name
      t.string :parent_contact_number
      t.string :gotra
      t.boolean :have_you_attended_previous_shibiras, default: false
      t.text :address
      t.boolean :notes, default: false
      t.boolean :glass, default: false
      t.text :remarks

      t.timestamps
    end
  end
end
