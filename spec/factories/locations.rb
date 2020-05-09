FactoryBot.define do
  factory :location do
    association :locationable
    state { "NY" }

    factory :service_area_location_data, class: "Line" do
      #attributes
      association :service_area_location_data

    end
  end
end
