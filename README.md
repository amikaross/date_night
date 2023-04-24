<h1 align="center">Date Night API</h1>

<br>
 
This repo is the Back End portion of the Date Night application built by [amikaross](https://www.github.com/amikaross).

<br>

## Table of Contents
- [Database Schema](#database-schema)
- [Tech & Tools Used](#tech-and-tools)
- [Developer Setup](#developer-setup)
- [Endpoints](#endpoints)

## Database Schema
<img src="doc/images/schema.png" alt="db schema" class="center" width="500" height="500">

## Tech and Tools
   ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) **2.7.4** <br>
   ![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) **5.2.8.1**<br>
   ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Developer Setup
  If you would like to demo this API on your local machine:
<ol>
  <li> Ensure you have Ruby 2.7.4 and Rails 5.2.8 installed </li>
  <li> Fork and clone down this repo and navigate to the root folder <code>cd date_night</code></li>
  <li> Run <code>bundle install</code> </li>
  <li> Run <code>rails db:{drop,create,migrate,seed}</code> </li>
  <li> (Optional) To run the test suite, run <code>bundle exec rspec spec</code> </li>
  <li> Run <code>rails s</code> </li>
</ol>
You should now be able to hit the API endpoints using Postman or a similar tool.<br>
Default host is <code>http://localhost:3000</code>

 
## Endpoints

<details close>
<summary> Create new user </summary><br>

  - POST "/api/v1/users"<br>
  - Sample request body: <br>
    ```
        {
          "user": {
              "email": "test@example.com",
              "password": "password"
            }
        }
    ```
  
  - Sample response body: <br>
    ```
      {
        "data": {
            "id": "2",
            "type": "user",
            "attributes": {
                "email": "testcase",
                "location": nil,
                "radius": nil,
                "lat": nil,
                "long": nil
              }
          }
      }
    ```
</details>


