# http://cloud.github.com/downloads/june29/horesase-boys/meigens.json
querystring = require('querystring')
fs = require('fs')
util = require('util')

file_path = require("path").resolve(__dirname, "meigens.json")


module.exports = (robot) ->
  robot.hear /^misawa (.*)/i, (msg) ->
    fs.readFile file_path, "utf8", (err, data)->
      jsons = JSON.parse data
      r = parseInt(Math.random() * jsons.length, 10)
      item = jsons[r]
      robot.reply msg.message.user, item.image