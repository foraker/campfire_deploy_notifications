require 'campfire_deploy_notifications/campfire'

module CampfireDeployNotifications
  class Notification < Struct.new(:options)
    def send
      default_rooms.each { |room| Campfire.message_room(room, generalized_message) }
      project_rooms.each { |room| Campfire.message_room(room, project_message) }
    end

    private

    def generalized_message
      "#{user} deployed #{project}:#{branch} to #{env}"
    end

    def project_message
      "#{user} deployed #{branch} to #{env}"
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

    def default_rooms
      wrap config.default_rooms
    end

    def project_rooms
      wrap config.project_rooms
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

    def wrap(configuration)
      Array[configuration].flatten.compact
    end
  end
end
