class Person < ApplicationRecord
  belongs_to :user, inverse_of: :person
end
