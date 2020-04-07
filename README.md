# Welcome to Better Projects!

This is a shameless clone (or mostly so) of Basecamp. It is not intended for commercial use. It is a personal project to show how Rails, Vue, and Inertia play together in a more complex application.

## The Stack

* Ruby on Rails
* Postgres
* VueJS
* Inertia

## Running Locally.

### System Requirements

The base of all system requirements are those required by Rails itself.

* yarn
* docker
* ruby 2.6.5
* bundler 2+
* postgres

### Getting Up And Running

* In a terminal window/tab run `bundle` (this will install all of your gems)
* In a terminal window/tab run `touch config/master.key` and paste "f61cd6a77a92695f73557d7a79d0afb9" in it
* In a terminal window/tab run `guard` (it does a lot, but mainly you want to watch for errors), and leave running
* In the same terminal window run `bin/setup`
* In a new terminal tab/window run `rails s`

This app lives on subdomains so you will access the app at http://app.lvh.me:3000. You will notice the subdomain changes after logging in as a user ;)

If you have trouble logging in as the default user (hulk@avengers.net), then open up rails console and update his password.. ex: `User.first.update(password: "google")`.

This should be all you have to do to get up and running. Docker is being used to containerize postgres and redis. It is a hyrbrid docker/local setup that is my personal sweet-spot. Feel free to fork and personalize it for yourself.

If you want to run tests just use `rake test` or use "m" to run single tests or directories of tests. Example: `m test/system/auth/sign_in_test.rb`
