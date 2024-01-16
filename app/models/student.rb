class Student < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date_of_birth", "gender", "id", "name", "updated_at"]
  end
end
