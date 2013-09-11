require "campfire_deploy_notifications/version"
require "campfire_deploy_notifications/configuration"
require 'campfire_deploy_notifications/notification'

module CampfireDeployNotifications
  extend self

  def config
    @config ||= Configuration.new({
      :rooms => [Room.new(:name => "Technology - internal")]
    })
  end

  def notify(options)
    Notification.new(options).send
  rescue Campfire::APIError => e
    error(e.message)
  end

  def error(message)
    puts "Can't send deploy hooks to Campfire"
    puts "#{message}\n"
  end
end
