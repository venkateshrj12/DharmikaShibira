class Student < ApplicationRecord
  self.table_name = :students
  def self.ransackable_attributes(auth_object = nil)
    self.column_names
  end

  has_one_attached :image


end
