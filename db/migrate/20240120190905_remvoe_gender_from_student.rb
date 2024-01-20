class RemvoeGenderFromStudent < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :gender
  end
end
