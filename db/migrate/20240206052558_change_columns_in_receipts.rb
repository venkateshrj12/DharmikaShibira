class ChangeColumnsInReceipts < ActiveRecord::Migration[7.0]
  def change
    remove_column :receipts, :seva_details
    change_column :receipts, :seva_amount, :integer
    change_column :receipts, :mode_of_payment, 'integer USING mode_of_payment::integer'
  end
end
