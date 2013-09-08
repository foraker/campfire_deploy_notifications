# Campfire Deploy Notifications

Deploy notifications for Campfire

## Installation

Add your Campfire credentials and subdomain

    export CAMPFIRE_SUBDOMAIN=your-subdomain
    export CAMPFIRE_TOKEN=your-api-token

## Project Integration

Add this line to your application's Gemfile:

    gem 'campfire_deploy_notifications'

And then execute:

    $ bundle

Require in your deploy.rb file:

    `require "campfire_deploy_notifications/capistrano"`

## Overriding Defaults

CampfireDeployNotifications is configurable.  For example, you can add a project specific room to be notified:

```Ruby
require "campfire_deploy_notifications/capistrano"

CampfireDeployNotifications.project_rooms = ["Your Project Room"]
```

- `default_rooms` - default rooms to notify of the deploy, specified by name.  Defaults to `["Technology - internal"]`.
- `project_rooms` - project specific rooms to notify of the deploy, specified by name.  Defaults to nothing.
- `project` - defaults to the repository name
- `env` - fetches `:rails_env` variable from Capistrano, defaults to 'production'
- `branch` - fetches `:branch` variable from Capistrano, defaults to 'master'
- `user` - the git user name
- `token` - default to the repository name
- `subdomain` - default to the repository name
