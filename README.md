# Campfire Deploy Notifications

## Installation

Add your Campfire credentials and subdomain

    export CAMPFIRE_SUBDOMAIN=your-subdomain
    export CAMPFIRE_TOKEN=your-api-token

## Project Integration

Add this line to your application's Gemfile:

    gem 'campfire_deploy_notifications', :gitub => "foraker/campfire_deploy_notifications"

Run `bundle install`, and then `require` the capistrano extension in your deploy.rb file:

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
CampfireDeployNotifications.config.rooms = [CampfireDeployNotifications::Room.new(:name => "Some Room")]

# Or, pointlessly

CampfireDeployNotifications.config.rooms = []
```

## Configuration

CampfireDeployNotifications has the following configuration options:
- `rooms` - Rooms to notify of the deploy.  Defaults to `CampfireDeployNotifications::Room.new(name: "Technology - internal")`.
- `project` - defaults to the repository name
- `env` - fetches `:rails_env` variable from Capistrano, defaults to 'production'
- `branch` - fetches `:branch` variable from Capistrano, defaults to 'master'
- `user` - the git user name
- `token` - defaults to CAMPFIRE_TOKEN
- `subdomain` - default to CAMPFIRE_SUBDOMAIN

## About Foraker Labs

<img src="http://assets.foraker.com/foraker_logo.png" width="400" height="62">

This project is maintained by Foraker Labs. The names and logos of Foraker Labs are fully owned and copyright Foraker Design, LLC.

Foraker Labs is a Boulder-based Ruby on Rails and iOS development shop. Please reach out if we can [help build your product](http://www.foraker.com).
