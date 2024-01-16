ActiveAdmin.register Student do
  permit_params :name, :date_of_birth, :gender

  filter :name
  filter :date_of_birth

  form do |f|
    f.inputs 'Student Details' do
      f.input :name
      f.input :date_of_birth, start_year: 1990, end_year: Time.current.year
      f.input :gender
    end
    f.actions
  end
end