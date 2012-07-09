hotlight-node
=============

Ever want to know when the Krispy Kerme hotlight is on in your area? Need to create a bot for your boss so he can run over and get his one vice?

Look no further!

Sample (in coffeescript)
--------------
```coffeescript
Hotlight = require 'hotlight'

hotlight = new Hotlight
hotlight.on "hots", (locations) =>
    console.log locations

hotlight.get_hots {zipcode: '98116'}
hotlight.get_hots {locations: '1115,1112'}
```

Installing
--------------
To install you only need to run ```npm install hotlight-node```

The code
--------------
hotlight-node is written in coffeescript and intended to run in [node.js](http://nodejs.org)

Tests are written in [mocha](http://visionmedia.github.com/mocha/) and [chai](http://chaijs.com/). Test can be run by running ```cake spec``` or ```./run_tests``` in the root of the project.

Javascript version
--------------
If you like you can get a javascript version of the node-highlight by running ```cake compile```. The interface is the same.
```javascript
var Hotlight = require('holight');

var hotlight = new Hotlight();
hotlight.once('hots',functions(locations){
    console.log(locations)
})
hotlight.get_hots({zipcode: '98116'})
hotlight.get_hots({locations: '1115,1112'})
```

Thanks Scott
-----------
This idea comes directly from my boss who wanted a hubot script that would tell him if the Krispy Kreme hotlight was on.

He made a nice gem over at https://github.com/ssikora/hotlight and provided me with the URLs for talking to the hotlight server.

Contributing
--------------
If you would like to help me out please fork the code, make your improvements and submit a pull request.