ActiveAdmin.register Payment do
  permit_params  :receiver_name, :mobile_number, :amount, :mode_of_payment, :instrument_number, :remarks, :voucher_id
  
  form do |f|
    f.inputs do
      f.input :mobile_number
      f.input :receiver_name
      f.input :voucher, label: "Payment Voucher", as: :select, collection: Payment.payment_voucher_options, input_html: { class: 'voucher-dropdown' }
      f.input :amount
      f.input :mode_of_payment
      f.input :instrument_number
      f.input :remarks
    end
    f.actions
  end
end
