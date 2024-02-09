class Payment < ApplicationRecord
  include PhoneNumberValidator
  self.table_name = :payments
  acts_as_paranoid

  belongs_to :voucher, class_name: "Voucher", foreign_key: "voucher_id"

  scope :deleted, -> { where.not(deleted_at: nil)}
  scope :active, -> { where(deleted_at: nil) }

  enum mode_of_payment: {cash: 0, bank: 1}

  before_save :generate_payment_number

  validates_presence_of :receiver_name, :mobile_number, :amount, :mode_of_payment
  validate :valid_mobile_number

  private

  def generate_payment_number
    payment_date = Time.now
    formatted_year = payment_date.strftime('%Y')

    payment_count = Payment.with_deleted.where(payment_date: payment_date.beginning_of_year..payment_date.end_of_year).count

    self.payment_number =  "#{formatted_year}_#{sprintf('%03d', payment_count + 1)}"
    self.payment_date = payment_date
  end

  def valid_mobile_number
    valid_phone_number(:mobile_number)
  end

  def self.payment_voucher_options
    Voucher.payments.map { |voucher| ["#{voucher.voucher_name}", voucher.id] }
  end
end
