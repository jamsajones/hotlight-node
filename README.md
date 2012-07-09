hotlight-node
=============

Ever want to know when the Krispy Kerme hotlight is on in your area? Need to create a bot for your boss so he can run over and get his one vice?

Look no further!

Note
----------

Synopsis
--------------
In coffeescript...
```coffeescript
Hotlight = require 'hotlight'

hotlight = new Hotlight
hotlight.on "hots", (locations) =>
    console.log locations

hotlight.get_hots {zipcode: '98116'}
hotlight.get_hots {locations: '1115,1112'}
```
And javascript...
```javascript
var Hotlight = require('holight');

var hotlight = new Hotlight();
hotlight.once('hots',functions(locations){
    console.log(locations)
})
hotlight.get_hots({zipcode: '98116'})
hotlight.get_hots({locations: '1115,1112'})
```
[more...](https://github.com/jamsajones/hotlight-node/wiki)

Installing
--------------
To install you only need to run ```npm install hotlight-node```

The code
--------------
hotlight-node is written in coffeescript and intended to run in [node.js](http://nodejs.org). I haven't tested it in the broser.

Testing
-------------
Tests are written in [mocha](http://visionmedia.github.com/mocha/) and [chai](http://chaijs.com/). Test can be run by running ```$ npm test``` in the root of the project.


Thanks Scott
-----------
This idea comes directly from my boss who wanted a hubot script that would tell him if the Krispy Kreme hotlight was on.

He made a nice gem over at https://github.com/ssikora/hotlight and provided me with the URLs for talking to the hotlight server.

Also, big thanks to Krispy Kreme and their technology department. Without them this app would not be possible. **Keep up the cool work.**

Copyright and License
-----------
The software belongs to everyone! MIT License is [here](https://raw.github.com/jamsajones/hotlight-node/master/LICENSE).

As for Kripy Kerme stuff. Well this app is not offically assosiated with Krispy Kreme or their partners or affilates. So, any and all Krispy Kreme copyrights and trademarks remain in tact.

Todo
-----------
See [issues](https://github.com/jamsajones/hotlight-node/issues)

Contributing
--------------
If you would like to help me out please fork the code, make your improvements and submit a pull request.