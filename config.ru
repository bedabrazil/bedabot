require 'rubygems'
require 'bundler'

$stdout.sync = true

Bundler.require

require './app'

run App