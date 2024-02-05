unless AdminUser.find_by(email: "dp.vijayapura@gmail.com").present?
  AdminUser.create!(email: 'dp.vijayapura@gmail.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end