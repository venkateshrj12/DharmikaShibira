unless AdminUser.find_by(email: "admin@example.com").present?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'Admin') if Rails.env.development?
end