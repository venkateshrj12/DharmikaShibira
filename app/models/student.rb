class Student < ApplicationRecord
  include PhoneNumberValidator

  self.table_name = :students

  enum student_type: {upaneeta: 0, anupaneeta: 1, baalaki: 2}

  has_one_attached :image, dependent: :destroy

  validates_presence_of :name, :date_of_birth, :student_type, :parent_name, :parent_contact_number, :gotra,  :address 

  validate :valid_student_phone_number, :valid_parents_phone_number

  # scope :upaneeta, -> { where(:student_type => 0)}
  # scope :anupaneeta, -> { where(:student_type => 1)}
  # scope :baalaki, -> { where(:student_type => 2)}

  def age_calculator
    return nil if self.date_of_birth.nil?
    birth_date = self.date_of_birth.to_date
    today = Date.today
    age = today.year - birth_date.year - ((today.month > birth_date.month || (today.month == birth_date.month && today.day >= birth_date.day)) ? 0 : 1)

    "#{age}-Yrs"
  end

  def valid_student_phone_number
    valid_phone_number(:student_contact_number)
  end

  def valid_parents_phone_number
    valid_phone_number(:parent_contact_number)
  end
end