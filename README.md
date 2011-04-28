SpreeEssentialCms
=================

SpreeEssentialCms is a full featured CMS for managing pages and content on your [Spree](http://spreecommerce.com) site.


Installation
------------

If you don't already have an existing Spree site, [click here](https://gist.github.com/946719) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Otherwise, follow these steps to get up and running with SpreeEssentialCms:

Add the necessary gems to your Gemfile... they haven't been released to Rubygems yet so we'll grab them from git.

    gem 'spree_essentials',    :git => 'git://github.com/citrus/spree_essentials.git'
    gem 'spree_essential_cms', :git => 'git://github.com/citrus/spree_essential_cms.git'

Run the generators to create the migration files.

    rails g spree_essentials:install
    rails g spree_essentials:cms

Migrate your database


Change Log
----------

**2011/4/26**

* Extracted from the Spree Essentials core.


To Do
-----

* more tests... many many more.
* A 'create translation' button that clones the current page's contents into another language
* add widgets that you can drop into any page
* page and menu caching/sweeping
* nested set for pages
* 0.30 and 0.40 compatibility
* create wiki pages


Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!


License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.