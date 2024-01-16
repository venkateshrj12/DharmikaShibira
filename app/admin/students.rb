ActiveAdmin.register Student do
  permit_params :name, :date_of_birth, :gender

  filter :name

  form do |f|
    f.inputs 'Student Details' do
      f.input :name
      f.input :date_of_birth, as: :date_time_picker
      f.input :gender
    end
    f.actions
  end
end
