class CreateAnupaneetas < ActiveRecord::Migration[7.0]
  def change
    create_table :anupaneetas do |t|

      t.timestamps
    end
  end
end
