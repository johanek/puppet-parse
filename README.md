# puppet-parse

[![Build Status](https://travis-ci.org/johanek/puppet-parse.png)](http://travis-ci.org/johanek/puppet-parse)

Analyse puppet manifests and report what classes and defines are specified, and their parameters and parameter documentation.

## Installation

    gem install puppet-parse

## Requirements

    rdoc
    facter

## Usage

### By hand

You can test one or more manifests by running

    puppet-parse <path(s) to file(s)>


### Rake tast

If you want to parse your entire modules directory, you can add
`require 'puppet-parse/puppet-parse' to your Rakefile and then run

    rake parse

## Contributing

You can do any of these:

1. Create new Pull Request
2. Create an issue
3. Write me an email
4. Complain about how useless my code is on twitter

