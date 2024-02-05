class AddDeletedAtToReceipts < ActiveRecord::Migration[7.0]
  def change
    add_column :receipts, :deleted_at, :datetime
  end
end
