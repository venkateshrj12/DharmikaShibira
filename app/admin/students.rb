ActiveAdmin.register Student do
  permit_params :name, :date_of_birth, :gender

  filter :name
end
