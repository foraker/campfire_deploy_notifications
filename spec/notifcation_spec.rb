require File.expand_path("../../lib/campfire_deploy_notifications/notification", __FILE__)

module CampfireDeployNotifications
  describe Notification do
    let(:campfire_message) { MockCampfireMessage.new }
    let(:room)             { Room.new(:name => "Test Room") }
    let(:config)           { OpenStruct.new(rooms: [room]) }

    let(:notification) do
      Notification.new({env: "production", branch: "master", repo: "git@github.com:organization/project.git"})
    end

    before do
      CampfireDeployNotifications.stub(config: config)
      stub_const("CampfireDeployNotifications::CampfireMessage", campfire_message)
      Notification.any_instance.stub(:`).with("git config user.name").and_return("User")
    end

    describe "#send" do
      it "notifies the technology room" do
        notification.send
        campfire_message.should have_messaged_room(room, "User deployed project:master to production")
      end

      it "sends only 1 notification" do
        notification.send
        campfire_message.call_count.should == 1
      end

      it "allows :branch configuration" do
        config.branch = "staging"
        notification.send
        campfire_message.should have_messaged_room(room, "User deployed project:staging to production")
      end

      it "allows :env configuration" do
        config.env = "staging"
        notification.send
        campfire_message.should have_messaged_room(room, "User deployed project:master to staging")
      end

      it "allows :user configuration" do
        config.user = "Special User Name"
        notification.send
        campfire_message.should have_messaged_room(room, "Special User Name deployed project:master to production")
      end

      it "allows :project configuration" do
        config.project = "project-2"
        notification.send
        campfire_message.should have_messaged_room(room, "User deployed project-2:master to production")
      end
    end
  end

  class MockCampfireMessage
    def deliver(room, message)
      raise "Already messaged room: #{room}" if calls[room]
      calls[room] = message
    end

    def has_messaged_room?(room, message)
      calls[room] == message
    end

    def calls
      @calls ||= {}
    end

    def call_count
      calls.keys.count
    end
  end
end