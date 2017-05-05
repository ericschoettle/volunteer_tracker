# _Volunteer Tracker_

#### _Website to track volunteers, projects, and project leaders 5/5/17_

#### By _**Eric Schoettle**_

## Description

_The Volunteer Tracker allows a non-profit organization to keep track of volunteers, projects, and project leaders. Projects may have multiple volunteers and volunteers may have multiple projects, though projects may have only one leader (that is, volunteers:projects is many-to-many whereas leaders:projects is one-to-many)_

_Volunteer Tracker offers full CRUD functionality: projects, volunteers, and leaders may all be created, read, updated, and deleted_

## Setup/Installation instructions

_Volunteer Tracker requires setup of a SQL database in order to function. To set up the necessary database with postgres and PSQL on a mac, follow the following instructions:_

* _Run the command "postgres" (without the quotes)_
* _Open another terminal window or tab and run the command "psql". This is the window in which you will run the commands to make the database._
* _Open another terminal window or tab and run the command "psql". This is the window in which you will run the commands to make the database._
* _Run the following commands in PSQL_
  * _"CREATE DATABASE volunteer_tracker;"_
  * _"\c volunteer_tracker"_
  * _"CREATE TABLE leaders (id serial PRIMARY KEY, name varchar, total_time interval);"_
  * _"CREATE TABLE projects (id serial PRIMARY KEY, name varchar, leader_id int, date_and_time timestamp, length interval);"_
  * _"CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, total_time interval);"_
  * _"CREATE TABLE projects_volunteers (id serial PRIMARY KEY, volunteer_id int, project_id int);"_
  * _"CREATE DATABASE volunteer_tracker_test WITH TEMPLATE volunteer_tracker;"_
* _Give yourself a pat on the back! You didn't mess it up! If you did (don't worry, so did I), here's a handy cheat sheet you can use to fix it: https://www.learnhowtoprogram.com/ruby/ruby-database-basics/sql-basics. Enjoy!_

## Support and contact details

_I'd be glad to offer support if you find yourself using this app, but much less glad to share my email address. Sorry, the latter wins_

## Known Bugs

_There are no known bugs at this time_

## Technologies Used

_Volunteer Tracker was built using Ruby, Sinatra, and Javascript with a postgres SQL database accessed via psql_

### License

*Volunteer Tracker is licensed under the MIT license*

Copyright (c) 2016 **_Eric Schoettle_**
