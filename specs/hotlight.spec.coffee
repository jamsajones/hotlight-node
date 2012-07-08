mocha = require 'mocha'
expect = require('chai').expect
request = require 'request'

Hotlight = require '../src/hotlight'

describe "Hotlight", ->
  locations = undefined
  hotlight = undefined
  orginal_post = request.post

  before ->
    request.post = (opts, callback) ->
      callback(undefined, undefined,
        '{"total":2,"data":{"locations":[{"hotLightOn":1,"locationId":1115,"title":"Sodo","address":"1900 1st Avenue S","city":"Seattle","state":"WA","zipcode":"98134","phone":"206-625-1554","geoLocation":"47.590000,-122.330000","url":"http://kkre.me/olE5bi","storeHours1":"Sun-Thurs 5:30am-10:00pm","storeHours2":"Fri- Sat 5:30am-11:00pm"},{"hotLightOn":0,"locationId":1112,"title":"Spokane","address":"15401 East Indiana Avenue","city":"Spokane Valley","state":"WA","zipcode":"99216","phone":"509-922-7101","geoLocation":"47.670000,-117.200000","url":"http://kkre.me/rlxTfW","storeHours1":"Sun-Thurs 5:30am-11:00pm","storeHours2":"Fri-Sat 5:30am-12:00am"}]},"status":"success","message":null}')

  after ->
    request.post = orginal_post

  beforeEach ->
    hotlight = new Hotlight

  describe "#status", ->
    describe "with zipcode", ->
      describe "wating for callback", ->
        beforeEach (done) ->
          hotlight.status {zipcode: '98116'}, (l) ->
            locations = l
            done()

        it "should be an array", ->
          expect(locations).to.be.instanceof(Array)

        it "should be have more than 0 locations", ->
          expect(locations.length).to.be.equal(2)

      describe "watching 'status' event", ->
        beforeEach (done) ->
          hotlight = new Hotlight
          hotlight.on "status", (l) ->
            locations = l
            done()

          hotlight.status {zipcode: '98116'}

        it "should be an array", ->
          expect(locations).to.be.instanceof(Array)

        it "should be have more than 0 locations", ->
          expect(locations.length).to.be.equal(2)

    describe "with location ids", ->
      describe "wating for callback", ->
        beforeEach (done) ->
          hotlight = new Hotlight
          hotlight.status {locations: '1115,1112'}, (l) ->
            locations = l
            done()

        it "should be an array", ->
          expect(locations).to.be.instanceof(Array)

        it "should be have more than 0 locations", ->
          expect(locations.length).to.be.equal(2)

      describe "watching for 'status' event", ->
        beforeEach (done) ->
          hotlight = new Hotlight
          hotlight.on "status", (l) ->
            locations = l
            done()

          hotlight.status {locations: '1115,1112'}

        it "should be an array", ->
          expect(locations).to.be.a.instanceof(Array)

        it "should be have more than 0 locations", ->
          expect(locations.length).to.be.equal(2)

  describe "#get_hots", ->
    describe "with zipcode", ->
      describe "waiting for callback", ->
        beforeEach (done) ->
          hotlight.get_hots {zipcode: '98116'}, (l) ->
            locations = l
            done()

        it "should be an array", ->
          expect(locations).to.be.a.instanceof(Array)
        it "should be above 0", ->
          expect(locations.length).to.be.equal(1)

      describe "watching for 'hots' event", ->
        beforeEach (done)->
          hotlight.on "hots", (l) ->
            locations = l
            done()

          hotlight.get_hots {zipcode: '98116'}

        it "should be an array", ->
          expect(locations).to.be.a.instanceof(Array)
        it "should be 1", ->
          expect(locations.length).to.be.equal(1)

    describe "with locations", ->
      describe "waiting for callback", ->
        beforeEach (done) ->
          hotlight.get_hots {locations: '1115,1112'}, (l) ->
            locations = l
            done()

        it "should be an array", ->
          expect(locations).to.be.a.instanceof(Array)
        it "should be above 0", ->
          expect(locations.length).to.be.equal(1)

      describe "watching 'hots' event", ->
        beforeEach (done) ->
          hotlight.get_hots {locations: '1115,1112'}, (l) ->
            locations = l
            done()

          it "should be an array", ->
            expect(locations).to.be.a.instanceof(Array)
          it "should be above 0", ->
            expect(locations.length).to.be.equal(1)