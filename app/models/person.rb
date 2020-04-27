class Person < ApplicationRecord
  belongs_to :user, inverse_of: :person

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  def name
    "#{first_name} #{last_name} (#{email})"
  end
end
