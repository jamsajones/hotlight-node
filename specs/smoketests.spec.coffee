mocha = require 'mocha'
expect = require('chai').expect
request = require 'request'
{assume, shared_behavior} = require './behaviors'
helpers = require './spec_helpers'

# These test will make sure that the service is working
# if thses tests are red then the world might be ending.
describe "Hotlights URL Smoketest", ->
    @results = undefined
    before (done)->
      # Warm up the request... sometimes it fails on the first one.
      helpers.do_krispy_request 'ListLocations', {zipcode:'98116'}, ->
        done()
    describe "for ListLocations", ->
      before (done)->
        helpers.do_krispy_request('ListLocations', {zipcode:'98116'}, (res) =>
          @results = res
          done())
      assume('results').behaves_like('a krispy response')

    describe "for HotLightStatus", ->
      before (done)->
        helpers.do_krispy_request('HotLightStatus', {locations:'1115'}, (res) ->
          @results = res
          done())

      assume('results').behaves_like('a krispy response')