class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.string :receipt_number
      t.date :receipt_date
      t.string :sevakarta_name
      t.string :mobile_number
      t.string :seva_details
      t.float  :seva_amount
      t.string :mode_of_payment
      t.string :instrument_number
      t.string :remarks

      t.timestamps
    end
  end
end
