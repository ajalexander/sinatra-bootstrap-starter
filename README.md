# Overview

This is a starter template for building a Sinatra web application.

Use this as a starting point for your Sinatra applications.

# Included Components

## Tech Stack

* Sinatra
* HAML
* Sequel
* RSpec
* Capybara
* Webkit
* Bootstrap
* jQuery

## Features / Modules

The application includes some basic items to get an application started. These include:

* A user account model
* A login page
* Logging to an application log file
* [Flash messaging](https://github.com/treeder/rack-flash)

## Default security infrastructure

The application also uses some application settings that are prudent to have running. These include:

* Having [rack-protection](https://github.com/rkh/rack-protection) running to safeguard against CSRF, XSS, etc.
* Using [bcrypt](https://github.com/codahale/bcrypt-ruby) for password hashing
* Encrypted session cookies
* Support for marking routes as anonymous vs. authenticated

## Testing

The starter template includes both RSpec and Cucumber test examples. The tests are run with code coverage monitored (with reports placed into the `results/` directory).

## Database infrastructure

The starter template uses different database types for different environments:

Environment | Database Type
:-----------|:-------------------------
development | SQLite database
test        | In-memory SQLite database
production  | MySQL database

Swapping out MySQL for another database type can be done by configuring a [different adapter](http://sequel.jeremyevans.net/rdoc/files/doc/opening_databases_rdoc.html) for Sequel.

# Directory Layout

Folder             | Description
:------------------|:----------------------------------------------------
db/migrations      | The Sequel migrations to alter the database schema
models             | The data models 
public             | The static resources for the application
public/css/app.css | Application-specific styling
public/js/app.js   | Application-specific JavaScript
routes             | The route handlers for requests
tasks              | Additional Rake tasks
test/spec          | The RSpec specification tests
test/feature       | The Cucumber feature tests
view_models        | View models for the application
views              | The HAML views
config.ru          | Rack configuration
app.rb             | The main application definition

# System setup

## Setup Ruby

Install Ruby using RVM.

* Install [RVM](https://rvm.io/rvm/install)
* Install and configure Ruby

        rvm install 2.2.0
        rvm use 2.2.0

* (Optionally) Configure a gemset

        echo YOUR_PROJECT_NAME > .ruby-gemset
        echo 2.2.0 > .ruby-version

## Install the depencies

Some of the Ruby gems have build dependencies that need to be before the gems can be installed.

On a Debian/Ubuntu system, you can install these by running:

        sudo apt-get install build-essential libmysqlclient-dev libxslt-dev libxml2-dev build-essential libqtwebkit-dev

## Install the gems

        bundle install

## Setup environment variables

Environment variables are loaded in from a `.env` file. See the `env.example` file for example configuration.

The `SESSION_SECRET` key is used to encrypt the browser session. To generate a session secret key for your application:

        require 'securerandom'
        SecureRandom.hex(40)

The `DATABASE_URL` configures the URL for the database. This URL also indicates to Sequel which database adapter to use.
Examples include:

Database | Example Url
:--------|:-----------
SQLite   | `sqlite://db/development.db`
MySQL    | `mysql2://<USER>:<PASSWORD>@<HOST>/<DATABASE>`

# Tasks

Configure the database

        rake db:migrate

Load seed data (to have data available for development)

        rake db:seed

Run the application

        rake start

Run the tests

        rake db:test:all

For a full list of tasks available

        rake -T
