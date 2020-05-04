module OfflineHelper
  def has_internet?
    require "resolv"
    dns_resolver = Resolv::DNS.new()
    begin
      dns_resolver.getaddress("symbolics.com")
      return true
    rescue Resolv::ResolvError => e
      return false
    end
  end
end