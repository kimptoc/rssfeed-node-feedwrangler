rssfeed-node-feedwrangler
==================

[![Build Status via Travis CI](https://travis-ci.org/kimptoc/rssfeed-node-feedwrangler.png?branch=master)](https://travis-ci.org/kimptoc/rssfeed-node-feedwrangler)

Node based library to access Feedwrangler service - http://feedwrangler.net/


-- TODO

handle FW method - add_feed_and_wait (maybe)

Get Travis working

Encrypt keys in .travis.yml

Basic list/add feeds

See also https://github.com/kimptoc/rssfeed-node-local.git

API
- requiresLogin - false
- auth/login - probably null for this
- feeds - what feeds they have (list, add, delete)
- entries - (in feeds, list, update - read/starred)
- supportsTags - might not support tags/folders
- tags - for feeds, can be in multiple


To run the CLI, do:

FW_CLIENT_KEY=[your feedwranger client key] ./bin/rssfeed

Only supports login and listing feeds - not sure it will progress beyond that...