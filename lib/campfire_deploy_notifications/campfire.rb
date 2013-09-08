require 'tinder'

module CampfireDeployNotifications
  class Campfire
    class APIError < StandardError ; end

    def self.message_room(room_name, message)
      self.new.message_room(room_name, message)
    end

    def message_room(room_name, message)
      find_room(room_name).speak(message)
    end

    def find_room(room_name)
      adapter.find_room_by_name(room_name) ||
      raise(APIError, "Could not find Campfire room named #{room_name}")
    end

    def subdomain
      config.subdomain ||
      ENV["CAMPFIRE_SUBDOMAIN"] ||
      raise(APIError, "Could not find CAMPFIRE_SUBDOMAIN in your environment")
    end

    def token
      config.token ||
      ENV["CAMPFIRE_TOKEN"] ||
      raise(APIError, "Could not find CAMPFIRE_TOKEN in your environment")
    end

    def adapter
      @adapter ||= Tinder::Campfire.new subdomain, :token => token
    end

    def config
      CampfireDeployNotifications.config
    end
  end
end
