require 'tinder'

module CampfireDeployNotifications
  class CampfireMessage < Struct.new(:room, :message)
    class APIError < StandardError ; end

    def self.deliver(room, message)
      self.new(room, message).deliver
    end

    def deliver
      find_room.speak(message)
    end

    def find_room
      adapter.find_room_by_name(room.name) ||
      raise(APIError, "Could not find Campfire room named #{room.name}")
    end

    def adapter
      @adapter ||= Tinder::Campfire.new room_subdomain, :token => room_token
    end

    def room_subdomain
      room.subdomain || default_subdomain
    end

    def room_token
      room.token || default_token
    end

    def default_subdomain
      config.subdomain ||
      ENV["CAMPFIRE_SUBDOMAIN"] ||
      raise(APIError, "Could not find CAMPFIRE_SUBDOMAIN in your environment")
    end

    def default_token
      config.token ||
      ENV["CAMPFIRE_TOKEN"] ||
      raise(APIError, "Could not find CAMPFIRE_TOKEN in your environment")
    end

    def config
      CampfireDeployNotifications.config
    end
  end
end
