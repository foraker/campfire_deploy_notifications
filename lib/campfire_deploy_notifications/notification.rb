require 'campfire_deploy_notifications/room'
require 'campfire_deploy_notifications/campfire_message'

module CampfireDeployNotifications
  class Notification < Struct.new(:options)
    def send
      config.rooms.each { |room| CampfireMessage.deliver(room, message) }
    end

    private

    def message
      "#{user} deployed #{project}:#{branch} to #{env}"
    end

    def env
      config.env || options[:env] || "production"
    end

    def branch
      config.branch || options[:branch] || "master"
    end

    def project
      config.project || repo_name
    end

    def user
      config.user || `git config user.name`.strip
    end

    def repo_name
      options.fetch(:repo, "")[/(?<=\/).*(?=\.git)/]
    end

    def config
      CampfireDeployNotifications.config
    end
  end
end
