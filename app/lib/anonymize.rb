class Anonymize
  def self.name(name)
    return if name.blank?

    names = name.split(" ")
    names.map do |n|
      initial = n.first
      n = '*' * n.length
      initial + n[1..-1]
    end.join(" ")
  end

  def self.email(email)
    return if email.blank?

    at_index = email.index("@")
    words = email.split(".")
    top_level_domain = words.pop

    masked_email = "*" * words.join(".").length
    masked_email[at_index] = "@"
    masked_email.concat(".", top_level_domain)
  end
end
