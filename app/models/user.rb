class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable# and :omniauthable

  has_many :communication_logs, as: :created_by
  has_one :person

  def admin?
    true # TODO - connect this to pundit
  end

  def name
    "#{email}"
  end

end
