class Student < ApplicationRecord
  self.table_name = :students

  enum gender: {male: 0, female: 1, others: 2}

  has_one_attached :image, dependent: :destroy

  validates_presence_of :name, :date_of_birth, :type, :parent_name, :parent_contact_number, :gotra,  :address 
  validates_inclusion_of  :notes, :glass, :have_you_attended_previous_shibiras, in: [true, false]

  def age_calculator
    return nil if self.date_of_birth.nil?
    birth_date = self.date_of_birth.to_date
    today = Date.today
    age = today.year - birth_date.year - ((today.month > birth_date.month || (today.month == birth_date.month && today.day >= birth_date.day)) ? 0 : 1)

    "#{age}-Yrs"
  end
end