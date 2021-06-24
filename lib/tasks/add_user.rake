task add_user: :environment do
  email = ENV['EMAIL']
  password = ENV['PASSWORD']

  User.create!(email: email, password: password, password_confirmation: password, confirmed_at: Time.current)
end
