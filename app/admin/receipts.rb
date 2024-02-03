ActiveAdmin.register Receipt do
  permit_params (Receipt.column_names - ["receipt_number"])
  
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
    actions
  end

  show do
    attributes_table do
      row :id
      row :receipt_number
      row(:receipt_date) {|receipt| receipt.receipt_date.strftime('%Y%m%d')}
      row :mobile_number
      row(:sevakarta_name) {|receipt| receipt.sevakarta_name.titlecase}
      row :seva_details
      row :seva_amount
      row :mode_of_payment
      row :instrument_number
      row :remarks
    end
  end

  form do |f|
    f.inputs do
      f.input :receipt_date, start_year: Time.now.year, end_year: Time.now.year - 2
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
  end
end
