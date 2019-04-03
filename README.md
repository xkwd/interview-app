# Interview App

[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)

## Description

This no name app is currently in a playground state, yet is already lead by a straightforward and fundamental idea to publish and discuss interviews on specific topics. The app interface cares a lot about an interviewee. Thus, many already built and currently developed features are to provide user friendly environment for those willing to publish an interview. The other important part of the app is to present uploaded interviews in an elegant way and to allow convenient and spam protected discussion.

## Stack

* __Ruby__: `2.6.2`
* __Rails__: `5.2.3`
* __Database__: `PostgreSQL`

## Details

* Nested AJAXified comments with polymorphic associations
* Two level deep nested forms
* Endless AJAXified scroll
* Search with Ransack
* Well planned database structure
* Standard Devise authentication
* RSpec tests
* Discourse powered forum `in progress`
* Machine state for the interview publishing form `in progress`

## Steps to set up locally

To run the app on your local machine you need to install:

- Ruby
- Rails
- PostgreSQL

Then:

* `bundle install` to download and install gems
* `cp config/database.yml.example config/database.yml` Update database user name and password if your PostgreSQL credentials are different from a default OS user name
* `bundle exec rspec` to make sure that all the tests are passing
* `rails db:setup` to create the database, load the schema and initialize it with the seed data
* `rails s` to run a server
