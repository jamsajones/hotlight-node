mocha = require 'mocha'
expect = require('chai').expect
request = require 'request'
{assume, shared_behavior} = require './behaviors'
_ = require 'underscore'

locations_property_names = [
  "locationId",
  "title",
  "address",
  "city",
  "state",
  "zipcode",
  "phone",
  "geoLocation",
  "url",
  "storeHours1",
  "storeHours2"
]

mock_data =
  location_response: {"total":2,"data":{"locations":[{"hotLightOn":1,"locationId":1115,"title":"Sodo","address":"1900 1st Avenue S","city":"Seattle","state":"WA","zipcode":"98134","phone":"206-625-1554","geoLocation":"47.590000,-122.330000","url":"http://kkre.me/olE5bi","storeHours1":"Sun-Thurs 5:30am-10:00pm","storeHours2":"Fri- Sat 5:30am-11:00pm"},{"hotLightOn":0,"locationId":1112,"title":"Spokane","address":"15401 East Indiana Avenue","city":"Spokane Valley","state":"WA","zipcode":"99216","phone":"509-922-7101","geoLocation":"47.670000,-117.200000","url":"http://kkre.me/rlxTfW","storeHours1":"Sun-Thurs 5:30am-11:00pm","storeHours2":"Fri-Sat 5:30am-12:00am"}]},"status":"success","message":null}


module.exports = helpers = {
  do_krispy_request: (rpc, params, cb)->
    req_data = {
      uri: "http://locations.krispykreme.com/Hotlight/#{rpc}.ashx",
      form: params
    }

    request.post req_data, (err,req,res) =>
      cb(JSON.parse(res))

  mock_data: mock_data
}


# This is what a krispy kreme location response should look like
shared_behavior "a krispy response", (ivar)->
  it "should be an object", ->
    expect(@[ivar]).to.be.an('object')

  it "should have a success", ->
   expect(@[ivar]).to.have.property('data')

# Here is a test to make sure the locations array is correct
shared_behavior "an array of locations", (ivar)->
  it "should be an array", ->
    expect(@[ivar]).to.be.instanceof(Array)
  it "elements should have location properties", ->
    for location in @[ivar]
      expect(location).to.contain.keys(locations_property_names)

# Same as above but takes a len option to test length of the array.
shared_behavior "an array of locations with length", (ivar, opts)->
  assume(ivar).behaves_like("an array of locations")

  it "should be have #{opts.len} locations", ->
    expect(@[ivar].length).to.be.equal(opts.len)

# Make sure that the array is orderd by distance properties
shared_behavior "an array orderd by property", (ivar, opts)->
    prop = opts.property
    it "should be orderd by #{prop} property", ->
      sorted = _.clone(@[ivar])
      sorted.sort((a,b)-> return parseFloat(a[prop]) - parseFloat(b[prop]))
      expect(@[ivar]).to.eql(sorted)
