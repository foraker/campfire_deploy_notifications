require File.expand_path("../../lib/campfire_deploy_notifications/notification", __FILE__)

module CampfireDeployNotifications
  describe Notification do
    class Campfire
      def message_room(room, message)
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

    let(:campfire) { Campfire.new }
    let(:config)   { OpenStruct.new(default_rooms: ["Technology - internal"]) }
    let(:notification) do
      Notification.new({env: "production", branch: "master", repo: "git@github.com:organization/project.git"})
    end

    before do
      CampfireDeployNotifications.stub(config: config)
      stub_const("CampfireDeployNotifications::Campfire", campfire)
      Notification.any_instance.stub(:`).with("git config user.name").and_return("User")
    end

    describe "#send" do
      it "notifies the technology room" do
        notification.send
        campfire.should have_messaged_room("Technology - internal", "User deployed project:master to production")
      end

      it "sends only 1 notification" do
        notification.send
        campfire.call_count.should == 1
      end

      it "allows :branch configuration" do
        config.branch = "staging"
        notification.send
        campfire.should have_messaged_room("Technology - internal", "User deployed project:staging to production")
      end

      it "allows :env configuration" do
        config.env = "staging"
        notification.send
        campfire.should have_messaged_room("Technology - internal", "User deployed project:master to staging")
      end

      it "allows :project configuration" do
        config.project = "project-2"
        notification.send
        campfire.should have_messaged_room("Technology - internal", "User deployed project-2:master to production")
      end

      context "a project_rooms configuration is present" do
        before { config.project_rooms = ["Project Room"] }

        it "notifies the technology room" do
          notification.send
          campfire.should have_messaged_room("Project Room", "User deployed master to production")
        end

        it "sends 2 notifications" do
          notification.send
          campfire.call_count.should == 2
        end
      end
    end
  end
end