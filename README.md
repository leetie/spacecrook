This is the final project for [The Odin Project's](https://theodinproject.com) course on Rails! It is supposed to be a Facebook like web application, with user authentication, fun associations, nested routes, etc. I will be trying to implement AWS asset storage for users, as well as user registration with the Devise gem and common social media apis. A mailer will be set up with the Sendgrid addon for Heroku upon deployment to production. 

* 08/13
  Currently I've got the project in a spot where it's mostly working. I still have to add a mailer, and user registration via api. As of right now, I've got Activestorage configured with Amazon S3, brought bootstrap in, and have mostly finished my model associations. Still have to create the friend model because right now I'm using only a request model to map users to other users. It will definitely DRY up the code a lot. Another thing that needs to be worked on are the Activerecord queries I've got everywhere in the controllers and views.


```bash
  yarn add bootstrap jquery popper.js
```

* 08/15
  Configured Devise for confirmable, and configured actionmailer for gmail. 

  First, in development.rb and production.rb, configure actionmailer settings. 
  ```ruby
    config.action_mailer.perform_caching = false
    config.action_mailer.default_options = {from: ENV['EMAIL_USER']}
    config.action_mailer.default_url_options = {:host => 'localhost:3000'}  
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :address => "smtp.gmail.com",
      :port => 587,
      :domain => "example.com",
      :authentication => :login,
      :user_name => ENV['EMAIL_USER'],
      :password => ENV['EMAIL_PASSWORD']
  }
  ```
  Add dotenv-rails to gemfile run bundle
  ```bash
  echo 'dotenv-rails' >> Gemfile
  bundle install
  ```
  Add environment variables to .env
  ```bash
  echo EMAIL_USER=user >> .env ; echo EMAIL_PASSWORD=password >> .env
  ```
  Add .env to gitignore
  ```bash
  echo /.env >> .gitignore
  ```


    In config/initializers/devise.rb, configure
    ```ruby
      config.mailer_sender = ENV['EMAIL_USER']

      # Configure the class responsible to send e-mails.
      config.mailer = 'Devise::Mailer'

      # Configure the parent class responsible to send e-mails.
      config.parent_mailer = 'ActionMailer::Base'
    ```
Second, set environment variables in heroku
```bash
heroku run bash
heroku config:set EMAIL_USER=user
heroku config:set EMAIL_PASSWORD=password
```
Restart server
```bash
heroku restart
```
