mio
==================================

MicroBlog for Laboratory.

Requirement
--------------
* Ruby 1.9.2
* MySQL
* RubyGems
* Bundler

Installation
--------------
    $ cd mio/
    $ cp ./config/application.yml.sample ./config/application.yml
    $ cp ./config/database.yml.sample ./config/databse.yml
    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rails s
