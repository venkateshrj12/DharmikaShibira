class Receipt < ApplicationRecord
  include PhoneNumberValidator
  self.table_name = :receipts
  acts_as_paranoid

  belongs_to :voucher, class_name: "Voucher", foreign_key: "voucher_id"

  scope :deleted, -> { where.not(deleted_at: nil)}
  scope :active, -> { where(deleted_at: nil) }

  enum mode_of_payment: {cash: 0, bank: 1}

  before_save :generate_receipt_number

  validates_presence_of :sevakarta_name, :mobile_number, :seva_amount, :mode_of_payment
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

  def self.receipt_voucher_options
    Voucher.receipts.map { |voucher| ["#{voucher.voucher_name} - (₹#{voucher.amount})", voucher.id, data: { amount: voucher.amount }] }
  end
end
