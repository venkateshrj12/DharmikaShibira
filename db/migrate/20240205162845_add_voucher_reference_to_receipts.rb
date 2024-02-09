class AddVoucherReferenceToReceipts < ActiveRecord::Migration[7.0]
  def change
    add_reference :receipts, :voucher, foreign_key: true
  end
end
