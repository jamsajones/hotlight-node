mocha = require 'mocha'
expect = require('chai').expect
request = require 'request'

#empty class for shared behaviors
behaviors = {}

assume = (ivar)->
  ctx = @
  behaves_like: (behavior, opts={}) ->
    behaviors["#{behavior}"].call(ctx, ivar, opts)

shared_behavior = (name, fn)->
    behaviors["#{name}"] = fn

module.exports = {assume: assume, shared_behavior: shared_behavior}