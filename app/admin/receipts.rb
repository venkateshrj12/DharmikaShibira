ActiveAdmin.register Receipt do
  config.per_page = [10, 20, 30, 50, 100]
  actions :all, except: [:destroy]
  permit_params :sevakarta_name, :mobile_number, :seva_amount, :mode_of_payment, :instrument_number, :remarks, :created_at, :updated_at, :deleted_at, :voucher_id

  scope :active, default: true
  scope :deleted
  scope :all
  
  index do
    selectable_column
    id_column
    column :receipt_number
    column (:receipt_date) {|receipt| receipt.receipt_date.strftime("%d %b %Y")}
    column :mobile_number
    column (:sevakarta_name) {|receipt| receipt.sevakarta_name.titlecase}
    column "Seva Voucher" do |receipt|
      receipt&.voucher&.voucher_name
    end
    column :seva_amount
    column (:mode_of_payment) {|receipt| receipt.mode_of_payment.titlecase}
    column :instrument_number
    column :remarks
    column :deleted_at do |receipt|
      span receipt.deleted_at.present? ? receipt.deleted_at.strftime("%Y-%m-%d %H:%M:%S") : '--', style: "color: #{receipt.deleted_at.present? ? 'red' : 'black'}; font-weight: bold;"
    end
    actions 
  end

  show do
    attributes_table do
      row :id
      row :receipt_number
      row(:receipt_date) {|receipt| receipt.receipt_date.strftime("%d %b %Y")}
      row :mobile_number
      row(:sevakarta_name) {|receipt| receipt.sevakarta_name.titlecase}
      row "Seva Voucher" do |receipt|
        receipt&.voucher&.voucher_name
      end
      row :seva_amount
      row :mode_of_payment
      row :instrument_number
      row :remarks
      row :deleted_at
    end
  end

  form do |f|
    f.inputs do
      f.input :mobile_number
      f.input :sevakarta_name
      f.input :voucher, label: "Seva Voucher", as: :select, collection: Receipt.receipt_voucher_options, input_html: { class: 'voucher-dropdown' }
      f.input :seva_amount, hint: 'Amount will be automatically filled based on the selected voucher.'
      f.input :mode_of_payment
      f.input :instrument_number
      f.input :remarks
    end
    f.actions
    script do
      <<-SCRIPT.html_safe
        $(document).ready(function(){
          $('.voucher-dropdown').on('change', function(){
            var selectedVoucher = $(this).find(':selected');
            var amount = selectedVoucher.data('amount');
            $('input#receipt_seva_amount').val(amount);
          });
        });
      SCRIPT
    end
  end

  controller do
    def new
      @receipt = Receipt.new(receipt_date: Time.now.to_date)
    end

    def scoped_collection
      Receipt.with_deleted
    end
  end

  action_item :restore, only: :show, if: proc { resource.deleted_at.present? } do
    link_to 'Restore Receipt', restore_admin_receipt_path(resource), method: :put
  end

  member_action :restore, method: :put do
    resource.recover
    redirect_to admin_receipts_path, notice: 'Receipt restored successfully.'
  end

  action_item :delete, only: :show, if: proc { resource.deleted_at.nil? } do
    link_to 'Delete Receipt', delete_admin_receipt_path(resource), method: :put
  end

  member_action :delete, method: :put do
    resource.destroy
    redirect_to admin_receipts_path, alert: 'Receipt deleted successfully.'
  end
end
