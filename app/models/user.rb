class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable# and :omniauthable

  has_many :communication_logs, as: :created_by
  has_one :person

  accepts_nested_attributes_for :person

  def sys_admin?
    true # TODO - connect this to pundit
  end

  def admin?
    true # TODO - connect this to pundit
  end

  def name
    "#{person&.name || email}"
  end

  def preferred_locale
    person&.preferred_locale
  end
end
