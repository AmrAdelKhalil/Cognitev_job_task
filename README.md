# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.4.2

* System dependencies:
- Devise  
- rspec-rails

* Configuration
- sqlite3

* Database creation
- rake db:setup
- rake db:migrate

* Database initialization


* How to run the test suite
- rspec

* Services
- Task1:
  request_url: http://localhost:3000/users.json
  method: post
  params:
    type: JSON,
    format:
    {
  	  "user": {
    	  "email": "amr@gmail.com",
    		"first_name":"amr",
    		"last_name": "adel",
    		"avatar":"1.jpeg",
    		"country_code":"eg",
    		"phone_number":"01112349621",
    	  "gender":"male",
    	  "birthdate":"2017-02-01"
    	}
    }

- Task2:
  request_url: http://localhost:3000/users/sign_in.json
  method: post
  params:
    type: JSON,
    format: {"user":{"phone_number":"01112349621","password":"123456"}}

- Task3:
  request_url: http://localhost:3000/statuses
  method: post
  params:
    type: JSON,
    format: {"phone_number":"01112349621","auth_token":"ef2b90e9aba94168b791fd3f2e695b29", "status":"cool"}
    requires: you have to get auth_token by running task2 first
