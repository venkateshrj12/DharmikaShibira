class Voucher < ApplicationRecord
  has_many :receipts

  enum voucher_type: {receipts: 0, payments: 1}
end
