require File.expand_path("../../lib/campfire_deploy_notifications/configuration", __FILE__)
require File.expand_path("../../lib/campfire_deploy_notifications/room", __FILE__)

module CampfireDeployNotifications
  describe Configuration do
    let(:configuration) { Configuration.new }

    describe "#add_room" do
      it "creates a room with the specified options" do
        configuration.add_room(name: "New Room")
        configuration.rooms.should == [Room.new(name: "New Room")]
      end
    end

    describe "#rooms" do
      it "handles nil rooms" do
        configuration.rooms = nil
        configuration.rooms.should == []
      end

      it "flattens the room list" do
        room_1, room_2 = double, double
        configuration.rooms = [[room_1], [room_2]]
        configuration.rooms.should == [room_1, room_2]
      end
    end
  end
end
