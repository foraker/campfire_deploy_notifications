module CampfireDeployNotifications
  class Room
    attr_reader :name, :subdomain, :token

    def initialize(options)
      @name      = options[:name] || raise("Missing room :name")
      @subdomain = options[:subdomain]
      @token     = options[:token]
    end

    def ==(other)
      name == other.name &&
      subdomain == other.subdomain &&
      token == other.token
    end
  end
end