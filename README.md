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
1: Clone the repository
2: Run update.sh to install the required gems
3: You will need devise.rb in config/initializers .  To create it, comment out devise code and run 'rails generate devise:install'.  Restore devise code to prevent crashes.

License & Authors
-----------------
- Author:: Forest Handford (forest.handford+VS@gmail.com)

```text
Copyright 2014, Vote Squared

Licensed under the MIT License;
You may not use this file except in compliance with the License.