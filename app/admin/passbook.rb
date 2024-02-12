# app/admin/passbook.rb
ActiveAdmin.register_page "Cashbook" do
  content title: "Cashbook" do
    columns do
      column do
        panel "Transactions" do
          transactions = (Receipt.where(mode_of_payment: "cash") + Receipt.where(mode_of_payment: "bank") + Payment.where(mode_of_payment: "cash") + Payment.where(mode_of_payment: "bank")).sort_by(&:created_at)

          running_total_cash = 0
          running_total_bank = 0

          table_for transactions do
            column("Date") do |transaction|
              if transaction.is_a?(Receipt)
                link_to transaction.created_at.to_date, admin_receipt_path(transaction)
              else
                link_to transaction.created_at.to_date, admin_payment_path(transaction)
              end
            end

            column("Type") { |transaction| transaction.class.name }

            column("Cash") do |transaction|
              amount = transaction.class.name == "Receipt" ? transaction.seva_amount : -transaction.amount
              transaction.mode_of_payment == "cash" ? amount : 0
            end

            column("Bank") do |transaction|
              amount = transaction.class.name == "Receipt" ? transaction.seva_amount : -transaction.amount
              transaction.mode_of_payment == "bank" ? amount : 0
            end

            column("Total Cash") { |transaction| running_total_cash += transaction.mode_of_payment == "cash" ? (transaction.class.name == "Receipt" ? transaction.seva_amount : -transaction.amount) : 0 }
            column("Total Bank") { |transaction| running_total_bank += transaction.mode_of_payment == "bank" ? (transaction.class.name == "Receipt" ? transaction.seva_amount : -transaction.amount) : 0 }

          end
        end
      end
    end

    columns do
      column do
        panel "Total Balance" do
          total_cash = Receipt.where(mode_of_payment: "cash").sum(:seva_amount) - Payment.where(mode_of_payment: "cash").sum(:amount)
          total_bank = Receipt.where(mode_of_payment: "bank").sum(:seva_amount) - Payment.where(mode_of_payment: "bank").sum(:amount)
          total_balance = total_cash + total_bank

          div "Total Cash: #{total_cash}"
          div "Total Bank: #{total_bank}"
          div "Total Balance: #{total_balance}"
        end
      end
    end
  end
end
