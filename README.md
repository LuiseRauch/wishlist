# README

* System requirements (commands for macOS)

  * git (`brew install git`)

  * gnupg2 (`brew install gpg`)

  * rvm (`\curl -L https://get.rvm.io | bash -s stable`)

  * npm (`brew install node`)

  * postgres (`brew install postgres`, `brew services start postgresql`)

  * bower (`npm install bower -g`)

* Ruby/Rails version

  This application is tested with Ruby 2.4.0 and Rails 5.0.2.

  `rvm install ruby-2.4.0`

  It's recommended to create a project-specific gemset before installing all gems with Bundler.

  `rvm use ruby-2.4.0@wishlist --create`

  `bundle install`

  (The application automatically chooses the right Ruby version and gemset through a corresponding `.ruby-gemset` and `.ruby-version` file)

* Configuration

  Create an `application.yml` file with API tokens for using SendGrid and embed.ly.

* Database creation

  `rake db:create`

* Database initialization

  `rake db:migrate`

* Run the application

  Start with `rails s`, connect to `localhost:3000`.

* How to run the test suite

  `rspec spec(/controllers/..)`

* External services

  * [Sendgrid](http://www.sendgrid.com)
  * [embed.ly](http://embed.ly/)


* Deployment instructions

  TBD
