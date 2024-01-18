class Student < ApplicationRecord
  self.table_name = :students

  enum gender: {male: 0, female: 1, others: 2}

  has_one_attached :image, dependent: :destroy
end