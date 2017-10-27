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
-------------------------------------------------
Task 1
Develop an end-point that satisfy the following requirement
Fields:
Note: Bold Fields are required and the phone number field should also be validated against
phone number format.
Example successful Response for a POST request should be as following:
{ "id": 1, "first_name": "Ali", "last_name": "Gamal", "country_code": "EG", "phone_number":
"01001234567", "gender": "male", "birthdate": "1988-03-29" }
Failing should be formatted as following:
{ "errors": { "first_name": [ { "error": "blank" } ], "last_name": [ { "error": "blank" } ], "country_code":
[ { "error": "inclusion" } ], "phone_number": [ { "error": "blank" }, { "error": "not_a_number" }, { "error":Technical Hiring Task
"not_exist" }, { "error": "invalid" }, { "error": "taken" }, { "error": "too_short", "count": 10 }, { "error":
"too_long", "count": 15 } ], "gender": [ { "error": "inclusion" } ], "birthdate": [ { "error": "blank" },
{ "error": "in_the_future" } ], "avatar": [ { "error": "blank" }, { "error": "invalid_content_type" } ], "email":
[ { "error": "taken" }, { "error": "invalid" } ] } }
Note: HTTP status code is 201 if new user else the suitable http status code should be returned.


Task 2
Create a new end-point to accept password and phone_number and return unique auth-token
along with the response upon success.


Task 3
Based on Task1 and 2, Develop an end-point that accepts following fields in POST request:
1. phone_number *
2. auth-token *
3. status *
Response:
1. Successful response should create a status object linked to the user object
2. Failing request can be either unauthorized request or bad request based on auth-token/phone number
combination.
