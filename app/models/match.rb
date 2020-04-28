class Match < ApplicationRecord
  belongs_to :receiver, polymorphic: true
  belongs_to :provider, polymorphic: true

  INITIATORS = ["receiver", "provider"]

  # belongs_to :coordinator, optional: true #, class_name: "Position" # TODO
  #
  def name
    "#{receiver.name} & #{provider.name}"
  end
end
