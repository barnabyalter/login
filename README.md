# Login
[![Build Status](https://travis-ci.org/NYULibraries/login.png?branch=development)](https://travis-ci.org/NYULibraries/login)
[![Dependency Status](https://gemnasium.com/NYULibraries/login.png)](https://gemnasium.com/NYULibraries/login)
[![Code Climate](https://codeclimate.com/github/NYULibraries/login.png)](https://codeclimate.com/github/NYULibraries/login)
[![Coverage Status](https://coveralls.io/repos/NYULibraries/login/badge.png?branch=development)](https://coveralls.io/r/NYULibraries/login)

The NYU Libraries' Login application is an [OAuth2](http://oauth.net/2/) server
that provides registered clients with a set of user metadata that can be used for
authorization decisions and feature provision.

## Authentication
Users can authenticate via the services listed below:

- NYU Shibboleth identity provider (i.e. NYU NetIDs)
- New School LDAP server (i.e. New School NetIDs)
- NYU Affiliates and Consortium Aleph patron accounts
- Facebook
- Twitter

## Users
The core user data provided is:

  - Username
  - Email
  - Last login date

## Identities
Users can have several identities, each of which contain their own set of metadata.
Below is a table listing the identities provided for a given login type.

| Login Type | Identities |
| ---------------------- | ---------- |
| NYU NetID | NYU Shibboleth <br \> Aleph |
| New School NetID | New School LDAP <br \> Aleph |
| NYU Affiliates and Consortium Aleph patron ID | Aleph |
| Facebook username | Facebook |
| Twitter username | Facebook |

For example, a user who logs in via NYU's Shibboleth identity provider will have an
NYU Shibboleth identity and also will have an Aleph identity. A user who logs in
via the New School's LDAP server will have a New School LDAP identity and an Aleph
identity. A user who logs in via Aleph, Facebook or Twitter, will only have an Aleph,
Facebook or Twitter identity.
