# Postgis Enabled Rails App
Ruby Version: 2.4.3  
Rails Version: Latest (using git in gem file)  
PostgreSQL: (latest)
This is the current state of the project that I'm adding stuff to
## Note:
It's important not to have an outdated Rails or Ruby installation to get this project to work, I wasted a lot of time trying to figure out why the gems I needed didn't work and it was because Rails and Ruby were older versions and I was using RailsInstaller to set up the environment which is BAD, install ruby first from their site, then do gem install rails from terminal and make sure to first uninstall any other versions of either Rails or Ruby).  
you should get no errors running this if you have recent versions of the software AND having done the database.yml modification to have your Postgres password in it instead of the one i set on my machine.

## What the database side has:  
An Artists table, with name, genre attributes. A Places (will rename to venues) table that has name, (will add address) and a column of type st_point (courtesy of PostGIS, this column will allow us to do various radius queries that require longitude latitude), an Event table and a Users table with username, email and password attributes. And finally join tables for artists->places and users->events. The users-events join table allows us to store the ids of users in one column and the ids of events associated with that user's id in another column. The users table also has an indexed email column, allowing fast lookup when we want to pull the profile of the user associated with that email address.

## How to interact with these tables:  
1. pull the project and navigate to that directory with the terminal
2. once in the directory (called postgis_test), you may need to run bundle install to get the gems, then run rails c to enter the interactive ruby terminal that will let you itneract with the database without using any SQL statements (this is thanks to Active Record that makes it so that you can use ruby code to interact with the database).
3. To create a user, type u1 (or any variable name you like) = User.create(username: "some name", email: "some email address", password: "give it a password")
Note that password is given on creation, but what is actually saved in the table is a hashed version of what the user inputted as their password, this is secure as we don't have to store actual passwords in a database. This hash is automatically generated courtesy of bcrypt, a Ruby gem for secure password authentication.
to view all users added to the database: User.all
To create an artist, you do the same thing, just give it the appropriate params.
To view what parameters need to be given to create an entry in any of the tables, check db/schema.rb in the project folder to view the database schema. Note that you never edit this file, if you want to modify the database you have to do it through migrations (google rails g migration to check the syntax of creating migrations). Migrations modify the schema. For example if we wanted to add a column called eventname to the event table, we have to run "rails g migration AddEventNameColumnToEventsTable" this creates a file in the db/migrations folder where changes to the database can be defined. After change is entered there, we run rails db:migrate (or rake db:migrate if you have older rails)

-For more on how to interact with the database: http://guides.rubyonrails.org/active_record_basics.html

Another thing to look at: app/models has class files for each of artist, user, event, place. These class files are basically empty at this point but they do have one line that specifies relations among them so it's useful to look at. User class also has basic validation of email address, not letting you add empty password, not allowing duplicate email addresses in the database, and no empty fields for email username and password.

What needs to be added: 
1. Add a basic user interface that allows using the HTML text fields to create users instead of manually creating them using the Rails console. This is mostly done by following the tutorial I shared earlier (https://www.railstutorial.org/book/). This also includes doing work on how user profiles will look like, and how the template for an artist page would look like.
2. Create dummy data to populate the artist and place tables so that we can create events that use both and demonstrate the relational feature. 
3. Investigate the calendar integration, what will we exactly show on the calendar per user? 
4. The tags feature. How will we use this and how to demonstrate it. For now we can search by genre because we have a column for it. 




