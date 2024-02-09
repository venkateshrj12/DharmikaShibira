class Voucher < ApplicationRecord
  has_many :receipts

  validates_presence_of :voucher_name, :voucher_type
  enum voucher_type: {receipts: 0, payments: 1}
end
