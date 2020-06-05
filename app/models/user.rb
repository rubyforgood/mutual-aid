class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable# and :omniauthable

  has_many :communication_logs, as: :created_by
  has_one :person

  accepts_nested_attributes_for :person

  enum role: UserRole.roles_as_hash, _suffix: true

  def role
    @role ||= UserRole.new(read_attribute(:role))
  end

  def name
    "#{person&.name || email}"
  end

  def preferred_locale
    person&.preferred_locale
  end
end
