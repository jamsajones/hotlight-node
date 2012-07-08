mocha = require 'mocha'
expect = require('chai').expect
request = require 'request'

# These test will make sure that the service is working
# if thses tests are red then the world might be ending.
describe "Hotlights URL Smoketest", ->
    results = undefined
    describe "for ListLocations", ->
      before (done)->
        req_data =
          uri: "http://locations.krispykreme.com/Hotlight/ListLocations.ashx"
          form: {zipcode:'98116'}

        request.post req_data, (err,req,res) =>
          results = JSON.parse(res)
          done()
      it "should be an object", ->
        expect(results).to.be.an('object')

      it "should have a success", ->
        expect(results).to.have.property('data')

    describe "for HotLightStatus", ->
      before (done)->
        req_data =
          uri: "http://locations.krispykreme.com/Hotlight/HotLightStatus.ashx"
          form: {locations:'1115'}

        request.post req_data, (err,req,res) =>
          results = JSON.parse(res)
          done()

      it "should be an object", ->
        expect(results).to.be.an('object')

      it "should have a success", ->
        expect(results).to.have.property('data')