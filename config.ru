require 'rubygems'
require 'bundler'

$stdout.sync = false

Bundler.require

require './app'

run App