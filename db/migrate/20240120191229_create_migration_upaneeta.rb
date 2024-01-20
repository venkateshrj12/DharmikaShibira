class CreateMigrationUpaneeta < ActiveRecord::Migration[7.0]
  def change
    create_table :upaneetas do |t|

      t.timestamps
    end
  end
end
