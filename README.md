Chef Dashboard
==============

A work in progress.

Hopefully might be helpful for monitoring which versions of which apps are deployed where.

Adding Applications
-------------------

You should be able to add more applications by adding classes into the `ChefDashboard::Configuration::Apps` module. Take a look at `dummy_app_configuration.rb`.

Specs
-----

At the moment there's not great test coverage--it's pretty much entirely done with acceptance tests. The unit tests aren't that useful at the moment.
