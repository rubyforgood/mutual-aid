class Messenger
  attr_reader :email, :identifier

  def self.delivery_statuses
    [ :sent,
      :connected,
      :undeliverable,
      :error,
    ]
  end

  def self.default_status
    :sent
  end

  # Can become a factory method once we support other media, eg SMS
  def initialize email, identifier = nil
    @email = email
    @identifier = identifier
  end

  def deliver_now
    email.deliver_now
    :sent
  rescue Net::SMTPError => e # TODO: what other errors do we need to allow/log
    Log.error e, "Error encountered delivering #{identifier} email"
    :error
  end
end
