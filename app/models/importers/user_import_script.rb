array = [
["kateaustinavon@gmail.com", "Kate Austin-Avon"],
["alesamarie@gmail.com", "Alesa DelSignore"],
["rebur122184@hotmail.com", "Rebecca Burgess"],
["kate5713@gmail.com", "Kate Kelly"],
["cbrennan1861@roadrunner.com", "Colette Brennan"],
["catalfamo_c@argylecsd.org", "Cathy Catalfamo"],
["rileybrennan21@gmail.com", "Riley Brennan"],
]

def import_users(array)
  pfcm = ContactMethod.where(name: "Email").first_or_create!
  array.each do |email, name|
    u = User.where(email: email).first_or_create!(password: "mutualaidggf")
    p = Person.where(name: name).first_or_create!(email: email, preferred_contact_method: pfcm)
    p.user ||= u
    p.save!
  end
end
