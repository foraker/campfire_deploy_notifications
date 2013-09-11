# Campfire Deploy Notifications

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

    require "campfire_deploy_notifications/capistrano"

## Adding Notified Rooms

By default, we notify the "Technology - internal" room using the subdomain and token supplied in the environment.

#### Adding a Room

```Ruby
CampfireDeployNotifications.config.add_room({
  :name => "Some Room",
  :subdomain => "an-alternative-subdomain", # Optional
  :token => "an-alternative-token" # Optional
})
```

#### Overriding the `rooms` configuration
```Ruby
CampfireDeployNotifications.config.rooms = [Room.new(:name => "Some Room")]

# Or, pointlessly

CampfireDeployNotifications.config.rooms = []
```

## Configuration

CampfireDeployNotifications has the following configuration options:
- `rooms` - default rooms to notify of the deploy, specified by name.  Defaults to `["Technology - internal"]`.
- `project_rooms` - project specific rooms to notify of the deploy, specified by name.  Defaults to nothing.
- `project` - defaults to the repository name
- `env` - fetches `:rails_env` variable from Capistrano, defaults to 'production'
- `branch` - fetches `:branch` variable from Capistrano, defaults to 'master'
- `user` - the git user name
- `token` - default to the repository name
- `subdomain` - default to the repository name
