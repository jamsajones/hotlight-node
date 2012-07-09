CoffeeScript = require 'coffee-script'
{exec} = require 'child_process'
fs = require 'fs'

task 'compile', 'Compile src/*.coffee lib', ->
  exec 'node_modules/.bin/coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'spec', 'Run spec tests', ->
  exec 'node_modules/.bin/mocha --growl --compilers coffee:coffee-script specs', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr