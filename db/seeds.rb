user = User.where(email: "mutualaidtesting@testing.com").first_or_create!(password: "testing")
