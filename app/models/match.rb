class Match < ApplicationRecord
  belongs_to :receiver, polymorphic: true, inverse_of: :matches_as_receiver
  belongs_to :provider, polymorphic: true, inverse_of: :matches_as_provider

  INITIATORS = ["receiver", "provider"]

  # belongs_to :coordinator, optional: true #, class_name: "Position" # TODO
  #
  def name
    "#{receiver.name} & #{provider.name}"
  end
end
