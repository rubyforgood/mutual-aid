FactoryBot.define do
  factory :location do
    street_address { "111 E Grandview Pkwy" }
    city           { "Traverse City" }
    state          { "MI" }
    zip            { "49684" }
  end
end
