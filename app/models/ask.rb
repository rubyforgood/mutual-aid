class Ask < Listing
  belongs_to :receiver, class_name: "Person", foreign_key: "person_id"
  belongs_to :service_area, inverse_of: :asks
end
