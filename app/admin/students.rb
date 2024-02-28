ActiveAdmin.register Student do
  config.per_page = [10, 20, 30, 50, 100]
  permit_params ["image"] << Student.column_names

  scope :all, default: true
  scope :upaneeta
  scope :anupaneeta
  scope :baalaki

  filter :name
  filter :parent_name
  filter :parent_contact_number


  index download_links: [:csv, :pdf] do
    selectable_column
    id_column
    column "Student's Details", sortable: 'name' do |student|
      simple_format("#{student.name}<br>#{student&.student_type&.titlecase}<br><br>#{student.age_calculator}<br>#{student.student_contact_number}")
    end
    column "Parent's details" do |student|
      simple_format("#{student.parent_name}<br>#{student.gotra}<br><br>#{student.address}<br>#{student.parent_contact_number}")
    end
    column :remarks, sortable: false
    column "Accessaries" do |student|
      link_to("Notes", toggle_notes_admin_student_path(student), method: :put, class: "status_tag color: #{student.notes ? 'green' : 'red'}") + '<br> <br>'.html_safe +
      link_to("Glass", toggle_glass_admin_student_path(student), method: :put, class: "status_tag color: #{student.glass ? 'green' : 'red'}")
    end
    
    actions
  end
  
  show do
    attributes_table do
      row :id
      row "Student's Details" do |student|
        simple_format("#{student.name}<br>#{student&.student_type&.titlecase}<br>#{student.gotra}<br>#{student.age_calculator}<br>#{student.student_contact_number}")
      end
      row "Parent's details" do |student|
        simple_format("#{student.parent_name}<br>#{student.parent_contact_number}<br><br>#{student.address}")
      end
      row :remarks
      row :notes
      row :glass
      row :have_you_attended_previous_shibiras
      row :image do |student|
        image_tag(student.image, size: '300x400') if student.image.present?
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :name, placeholder: "Name of Student"
      f.input :date_of_birth, start_year: Time.now.year, end_year: 1990
      f.input :student_type, as: :select
      f.input :student_contact_number, placeholder: "Whatsaap number"
      f.input :gotra
      f.input :parent_name, placeholder: "Parent or guardian name"
      f.input :parent_contact_number, placeholder: "Whatsaap number"
      f.input :address, placeholder: "Full address"
      f.input :remarks, placeholder: "Medications or any other info"
      f.input :have_you_attended_previous_shibiras
      f.input :notes, label: "Notes Received?"
      f.input :glass, label: "Glass Received?"
      f.input :image, as: :file
    end
    f.actions
  end

  member_action :toggle_notes, method: :put do
    student = Student.find(params[:id])
    student.update(notes: !student.notes)
    redirect_back(fallback_location: admin_students_path)
  end

    member_action :toggle_glass, method: :put do
    student = Student.find(params[:id])
    student.update(glass: !student.glass)  # Corrected from 'notes' to 'glass'
    redirect_back(fallback_location: admin_students_path)
  end
end