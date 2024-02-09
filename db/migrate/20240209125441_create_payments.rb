class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :payment_number
      t.date :payment_date
      t.string :receiver_name
      t.string :mobile_number
      t.integer :amount
      t.integer :mode_of_payment
      t.string :instrument_number
      t.string :remarks
      t.datetime :deleted_at
      t.references :voucher, foreign_key: true

      t.timestamps
    end
  end
end
