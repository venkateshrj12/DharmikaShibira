class Receipt < ApplicationRecord
  include PhoneNumberValidator
  acts_as_paranoid

  self.table_name = :receipts

  scope :deleted, -> { where.not(deleted_at: nil)}
  scope :active, -> { where(deleted_at: nil) }

  before_save :generate_receipt_number

  validates_presence_of :sevakarta_name, :mobile_number, :seva_details, :seva_amount, :mode_of_payment
  validate :valid_mobile_number

  private

  def generate_receipt_number
    receipt_date = Time.now
    formatted_year = receipt_date.strftime('%Y')

    receipt_count = Receipt.with_deleted.where(receipt_date: receipt_date.beginning_of_year..receipt_date.end_of_year).count

    self.receipt_number =  "#{formatted_year}_#{sprintf('%03d', receipt_count + 1)}"
    self.receipt_date = receipt_date
  end

  def valid_mobile_number
    valid_phone_number(:mobile_number)
  end
end
