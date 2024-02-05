ActiveAdmin.register Voucher do
  permit_params :voucher_type, :voucher_name
  config.filters = false
  actions :all, except: :show

  index do
    selectable_column
    id_column
    column(:voucher_type) {|voucher| voucher.voucher_type.humanize}
    column :voucher_name
    actions
  end

  form do |f|
    f.inputs do
      f.input :voucher_type, as: :select
      f.input :voucher_name
    end
    f.actions
  end
end
