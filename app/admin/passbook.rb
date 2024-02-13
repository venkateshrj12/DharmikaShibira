ActiveAdmin.register_page 'Cashbook' do
  content title: 'Cashbook' do
    @transactions = (Receipt.where(mode_of_payment: ["cash", "bank"]) + Payment.where(mode_of_payment: ["cash", "bank"])).sort_by(&:created_at)
    total_cash = Receipt.where(mode_of_payment: "cash").sum(:seva_amount) - Payment.where(mode_of_payment: "cash").sum(:amount)
    total_bank = Receipt.where(mode_of_payment: "bank").sum(:seva_amount) - Payment.where(mode_of_payment: "bank").sum(:amount)
    total_balance = total_cash + total_bank
    render partial: 'cashbook_page', locals: { transactions: @transactions, cash_total: total_cash, bank_total: total_bank, final_total: total_balance }
  end

  page_action :export_cashbook_file do
    @transactions = (Receipt.where(mode_of_payment: ["cash", "bank"]) + Payment.where(mode_of_payment: ["cash", "bank"])).sort_by(&:created_at)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Sl.No', "Type", "Voucher Name", "Date", "Receipts - Cash", "Receipts - Bank", "Payments - Cash", "Payments - Bank", "Total Cash", "Total Bank", "Total"]
      running_total_bank = 0
      running_total_cash = 0
      serial_counter = 0

      @transactions.each do |transaction|
        csv << [
          serial_counter += 1,
          transaction.is_a?(Receipt) ? "Receipt" : "Payment",
          transaction.voucher.voucher_name,
          transaction.created_at.to_date,
          transaction.mode_of_payment == "cash" && transaction.is_a?(Receipt) ? transaction.seva_amount : "",
          transaction.mode_of_payment == "bank" && transaction.is_a?(Receipt) ? transaction.seva_amount : "",
          transaction.mode_of_payment == "cash" && transaction.is_a?(Payment) ? -transaction.amount : "",
          transaction.mode_of_payment == "bank" && transaction.is_a?(Payment) ? -transaction.amount : "",
          running_total_cash += transaction.mode_of_payment == "cash" ? (transaction.is_a?(Receipt) ? transaction.seva_amount : -transaction.amount) : 0,
          running_total_bank += transaction.mode_of_payment == "bank" ? (transaction.is_a?(Receipt) ? transaction.seva_amount : -transaction.amount) : 0,
          running_total_bank + running_total_cash
        ]
      end
    end
    send_data csv_data, filename: "cashbook_data.csv"
  end

end
