class Receipt < ApplicationRecord
  self.table_name = :receipts

  before_save :generate_receipt_number

  private

  def generate_receipt_number
    receipt_date = Time.now
    formatted_date = Time.now.strftime('%y%m%d')

    receipt_count = Receipt.where(receipt_date: receipt_date).count

    self.receipt_number =  "#{formatted_date}_#{sprintf('%03d', receipt_count + 1)}"
  end
end
