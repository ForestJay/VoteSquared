VoteSquared
===================

The rails repository for Vote Squared's platform ( VoteSquared.org ).

Requirements
------------
Platforms:
- CentOS

Database:
- MongoDb

App Server:
- Web Brick for localhost and single threading
- Passenger + nginx for multi-threading

Installation Steps
------------------
1. Clone the repository
2. Run update.sh to install the required gems
3. You will need devise.rb in config/initializers .  To create it, comment out devise code and run 'rails generate devise:install'.  Restore devise code to prevent crashes.
4. Create /congig/initializers/admins.yml .  Add the ids for your admins to this file.
5. Create /congig/initializers/secrets.yml and place your SMTP settings for the environment configurations.

License & Authors
-----------------
- Author:: Forest Handford (forest.handford+VS@gmail.com)

```text
Copyright 2014, Vote Squared

Licensed under the MIT License;
You may not use this file except in compliance with the License.
