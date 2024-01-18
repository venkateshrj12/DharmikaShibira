ActiveAdmin.register Student do
  permit_params ["image"] << Student.column_names

  show do
    attributes_table do
      row :id
      row :name
      row :date_of_birth
      row :gender
      row :type
      row :have_you_attended_previous_shibiras
      row :notes
      row :glass
      row :gotra
      row :parent_name
      row :parent_contact_number
      row :address
      row :remarks
      row :image do |student|
        image_tag(student.image, size: '500') if student.image.present?
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :date_of_birth
      f.input :gender
      f.input :type
      f.input :have_you_attended_previous_shibiras, as: :select
      f.input :notes, as: :select
      f.input :glass, as: :select
      f.input :gotra
      f.input :parent_name
      f.input :parent_contact_number
      f.input :address
      f.input :remarks
      f.input :image, as: :file
    end

    f.actions
  end
end