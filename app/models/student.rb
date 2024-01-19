class Student < ApplicationRecord
  self.table_name = :students

  enum gender: {male: 0, female: 1, others: 2}

  has_one_attached :image, dependent: :destroy


  def age_calculator
    return nil if self.date_of_birth.nil?
    birth_date = self.date_of_birth.to_date
    today = Date.today
    age = today.year - birth_date.year - ((today.month > birth_date.month || (today.month == birth_date.month && today.day >= birth_date.day)) ? 0 : 1)

    "#{age}-Yrs"
  end
end