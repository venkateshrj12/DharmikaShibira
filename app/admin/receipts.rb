ActiveAdmin.register Receipt do
  config.per_page = [10, 20, 30, 50, 100]
  # actions :all, except: [:destroy]
  permit_params (Receipt.column_names - ["receipt_number"])

  scope :active, default: true
  scope :deleted
  scope :all
  
  index do
    selectable_column
    id_column
    column :receipt_number
    column(:receipt_date) {|receipt| receipt.receipt_date.strftime("%d %b %Y")}
    column :mobile_number
    column(:sevakarta_name) {|receipt| receipt.sevakarta_name.titlecase}
    column :seva_details
    column :seva_amount
    column :mode_of_payment
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
      row :seva_details
      row :seva_amount
      row :mode_of_payment
      row :instrument_number
      row :remarks
      row :deleted_at
    end
  end

  form do |f|
    f.inputs do
      # f.input :receipt_date, start_year: Time.now.year, end_year: Time.now.year - 2
      f.input :mobile_number
      f.input :sevakarta_name
      f.input :seva_details
      f.input :seva_amount
      f.input :mode_of_payment
      f.input :instrument_number
      f.input :remarks
    end
    f.actions
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
    button_to 'Restore', restore_admin_receipt_path(resource), method: :put
  end

  member_action :restore, method: :put do
    # resource.recover
    Receipt.with_deleted.find_by_id(resource.id).recover
    redirect_to admin_receipts_path, notice: 'Receipt restored successfully.'
  end
end
