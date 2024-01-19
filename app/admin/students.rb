ActiveAdmin.register Student do
  permit_params ["image"] << Student.column_names

  index do
    selectable_column
    id_column
    column "Student's Details" do |student|
      simple_format("#{student.name}<br>#{student.type}<br>#{student.gotra}<br>#{student.age_calculator}")
    end

    column "Parent's details" do |student|
      simple_format("#{student.parent_name}<br>#{student.parent_contact_number}<br><br>#{student.address}")
    end
    column :remarks
    column "Accessaries" do |student|
      link_to("Notes", toggle_notes_admin_student_path(student), method: :put, class: "status_tag color: #{student.notes ? 'green' : 'red'}") + '<br> <br>'.html_safe +
      link_to("Glass", toggle_glass_admin_student_path(student), method: :put, class: "status_tag color: #{student.glass ? 'green' : 'red'}")
    end
    actions
  end

  member_action :toggle_notes, method: :put do
    student = Student.find(params[:id])
    student.update(notes: !student.notes)
    redirect_to admin_students_path#, notice: "Notes status toggled successfully."
  end

  member_action :toggle_glass, method: :put do
  student = Student.find(params[:id])
  student.update(glass: !student.glass)  # Corrected from 'notes' to 'glass'
  redirect_to admin_students_path
end
  
  show do
    attributes_table do
      row :id
      row :name
      row :date_of_birth
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