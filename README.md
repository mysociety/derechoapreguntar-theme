Alavetelitheme
==============

[![Build Status](https://travis-ci.org/mysociety/derechoapreguntar-theme.svg)](https://travis-ci.org/mysociety/derechoapreguntar-theme)

This is a "hello world" type theme package for Alaveteli.

The intention is to support simple overlaying of templates and
resources without the need to touch the core Alaveteli software.

Typical usage should be limited to that described in the [documentation](http://alaveteli.org/docs/customising/themes/):


## To install:

In the Alaveteli general.yml configuration file change the default mysociety  theme repository to your theme repository in the THEME_URLS setting:

    THEME_URLS:
      - 'git://github.com/YOUR_GITHUB_USERNAME/YOUR_THEME_NAME.git'

You can then switch the theme the application is using:

    bundle exec rake themes:install

## To run the theme tests:

In the Alaveteli directory with the theme installed:

   bundle exec rspec lib/themes/derechoapreguntar-theme/spec

Copyright (c) 2011 mySociety, released under the MIT license
