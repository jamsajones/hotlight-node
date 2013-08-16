{EventEmitter} = require 'events'
request = require 'request'
qs = require 'querystring'

class Hotlight extends EventEmitter
  constructor: ()->

  status: (params, callback) ->
    throw "You must have a zipcode or location ids" unless params.zipcode? or params.locations?

    path = if params.zipcode? then '/Hotlight/ListLocations.ashx' else '/Hotlight/HotLightStatus.ashx'
    req_data =
      uri: "http://locations.krispykreme.com#{path}"
      form: {zipcode:params.zipcode, locations: params.locations}

    request.post req_data, (err,req,res) =>
      results = JSON.parse(res)

      @emit "status", results.data.locations
      if typeof callback is "function"
        callback(results.data.locations) unless err?

  get_hots: (params, callback) ->
    @on "status", (locations) =>
      hot_locations = (location for location in locations when location.hotLightOn is 1)

      @emit "hots", hot_locations
      if typeof callback is "function"
        callback(hot_locations)

    @status params

module.exports = Hotlight