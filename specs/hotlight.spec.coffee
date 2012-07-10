{EventEmitter} = require 'events'
mocha = require 'mocha'
expect = require('chai').expect
request = require 'request'
helpers = require './spec_helpers'
mock_data = require './mock_data'
{assume, shared_behavior} = require './behaviors'

Hotlight = require '../src/hotlight'

orginal_post = request.post

describe "Hotlight", ->
  before ->
    # Fake the post call
    request.post = (opts, callback) ->
      res = mock_data.zipcode()
      if opts.form.locations?
        res = mock_data.locations()
      callback(undefined, undefined, JSON.stringify(res))

  after ->
    request.post = orginal_post

  beforeEach ->
    @hotlight = new Hotlight

  it "should be an event emitter", ->
    expect(@hotlight).to.be.a.instanceof(EventEmitter)

  describe "#status", ->
    describe "should call callback with locations", ->
      describe "with zipcode", ->
        beforeEach (done) ->
          @hotlight.status {zipcode: '98116'}, (l) =>
            @locations = l
            done()

        assume('locations').behaves_like("an array of locations with length", {len: 7})
        assume('locations').behaves_like("an array orderd by property", { property: 'distance'})

      describe "with location ids", ->
        beforeEach (done) ->
          @hotlight.status {locations: '1115,1112'}, (l) =>
            @locations = l
            done()

        assume('locations').behaves_like("an array of locations with length", {len: 3})

    describe "should fire when locations found", ->
      describe "with zipcode", ->
        beforeEach (done)->
          @hotlight.once "status", (l) =>
            @locations = l
            done()
          @hotlight.status {zipcode: '98116'}

        assume('locations').behaves_like("an array of locations with length", {len: 7})
        assume('locations').behaves_like("an array orderd by property", { property: 'distance'})

      describe "with location ids", ->
        beforeEach (done)->
          @hotlight.once "status", (l) =>
            @locations = l
            done()
          @hotlight.status {locations: '1115,1112'}

        assume('locations').behaves_like("an array of locations with length", {len: 3})

  describe "#get_hots", ->
    describe "should call callback with locations", ->
      describe "with zipcode", ->
        beforeEach (done) ->
          @hotlight.get_hots {zipcode: '98116'}, (l) =>
            @locations = l
            done()

        assume('locations').behaves_like("an array of locations with length", {len: 3})
        assume('locations').behaves_like("an array orderd by property", { property: 'distance'})

      describe "with location ids", ->
        beforeEach (done) ->
          @hotlight.get_hots {locations: '1115,1112'}, (l) =>
            @locations = l
            done()

        assume('locations').behaves_like("an array of locations with length", {len: 2})

    describe "should fire when locations found", ->
      describe "with zipcode", ->
        beforeEach (done)->
          @hotlight.on "hots", (l) =>
            @locations = l
            done()
          @hotlight.get_hots {zipcode: '98116'}

        assume('locations').behaves_like("an array of locations with length", {len: 3})
        assume('locations').behaves_like("an array orderd by property", { property: 'distance'})

      describe "with location ids", ->
        beforeEach (done) ->
          @hotlight.on "hots", (l) =>
            @locations = l
            done()

          @hotlight.get_hots {locations: '1115,1112'}

        assume('locations').behaves_like("an array of locations with length", {len: 2})