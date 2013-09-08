require "campfire_deploy_notifications"

Capistrano::Configuration.instance.load do
  after :deploy, "campfire:notify_of_deploy"

  namespace :campfire do
    desc "Notify Campfire about the deploy"
    task :notify_of_deploy do
      CampfireDeployNotifications.notify(
        :repo   => fetch(:repository),
        :env    => fetch(:rails_env),
        :branch => fetch(:branch)
      )
    end
  end
end