unless AdminUser.find_by(email: "dp.vijayapura@gmail.com").present?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'Admin') if Rails.env.development?
end

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'Admin') if Rails.env.development?
