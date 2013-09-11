require "ostruct"

module CampfireDeployNotifications
  class Configuration < OpenStruct
    def add_room(options)
      self.rooms = rooms.push(Room.new(options))
    end

    def rooms
      Array[super].flatten.compact
    end
  end
end