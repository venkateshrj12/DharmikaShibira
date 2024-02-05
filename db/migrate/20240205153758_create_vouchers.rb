class CreateVouchers < ActiveRecord::Migration[7.0]
  def change
    create_table :vouchers do |t|
      t.integer :voucher_type
      t.string :voucher_name

      t.timestamps
    end
  end
end
