This is the final project for [The Odin Project's](https://theodinproject.com) course on Rails! It is supposed to be a Facebook like web application, with user authentication, fun associations, nested routes, etc. I will be trying to implement AWS asset storage for users, as well as user registration with the Devise gem and common social media apis. A mailer will be set up with the Sendgrid addon for Heroku upon deployment to production. 

* 08/13
  Currently I've got the project in a spot where it's mostly working. I still have to add a mailer, and user registration via api. As of right now, I've got Activestorage configured with Amazon S3, brought bootstrap in, and have mostly finished my model associations. Still have to create the friend model because right now I'm using only a request model to map users to other users. It will definitely DRY up the code a lot. Another thing that needs to be worked on are the Activerecord queries I've got everywhere in the controllers and views.


```bash
  yarn add bootstrap jquery popper.js
```
