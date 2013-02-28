# http://cloud.github.com/downloads/june29/horesase-boys/meigens.json
querystring = require('querystring')
fs = require('fs')
util = require('util')
TinySegmenter = require('./tiny_segmenter-0.2.js')
segmenter = new TinySegmenter()

file_path = require("path").resolve(__dirname, "meigens.json")

jsons = false

fs.readFile file_path, "utf8", (err, data)->
  jsons = JSON.parse data

# ランダムに返す.
return_random = ()->
  r = parseInt(Math.random() * jsons.length, 10)
  item = jsons[r]
  return item

# queryをセグメントして返す
return_by_query = (q)->
  segs0 = segmenter.segment(q, 0)
  segs1 = segmenter.segment(q, 1)
  segs = segs1
  # if segs0.length == 1
  #   segs = segs0
  console.log segs
  item = false
  is_finded = false
  for j in jsons
    if is_finded
      break
    for seg in segs
      if j.body.toLowerCase().indexOf(seg) >= 0
        is_finded = true
        item = j
        break
  return item

# 無ければランダムで返す
return_by_query_default_random = (q)->
  if q.length == 0
    return return_random()
  item = return_by_query(q)
  if not item
    return return_random()
  return item

module.exports = (robot) ->
  robot.hear /^(\s*)みさわ(\s*)(.*)/i, (msg) ->
    q = msg.match[3]
    item = return_by_query_default_random(q)
    txt = util.format("%s %s", item.body, item.image)
    return robot.reply msg.message.user, txt
