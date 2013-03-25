# Description:
#   はてブAPIから関連URLを探してreplyする
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <url> - 本文に含まれている<url>の関連URLが存在したらそのURLを返す
#   hubot <url> - <url>の関連URLが存在したらそのURLを返す、存在しなくても何か返す
#
# Author:
#   moqada

module.exports = (robot) ->

  noneCount = 0
  urlPattern = "(^#{robot.name}\\s+)?(https?:\/\/[-_.,0-9A-z*&#?=:/%]+)"
  phrases =
    none: [
      'ごめんけど、ないわ、これ'
      'すまん、ない'
      'ねーよ、なんもない'
      'もっと意識の高いURLください'
    ]
    nonenone: [
      '...ないもんはない！'
      '...だから、ないっつーの！'
      'あなたの予想に反してこのURLが見えているでしょうか？'
    ]
    exist: [
      'あったで'
      'めっけた'
      'ほい'
      'いいとおもいます'
    ]

  getPhrase = (key) ->
    list = phrases[key]
    list[parseInt Math.random() * list.length, 10]

  messageGen = (json) ->
    msg = getPhrase 'exist'
    msg += "\n\n#{json.title}\n#{json.count}はてﾌﾞ"
    if json.related
      urls = ("[#{e.count}] #{e.title}\n#{e.url}\n" for e in json.related)
      msg += "\n\n#{urls.join('\n')}"
    msg

  robot.hear new RegExp(urlPattern, 'i'), (msg) ->
    toMe = msg.match[1]
    url = msg.match[2]
    request = robot.http("http://b.hatena.ne.jp/entry/json/#{url}").get()

    request (err, res, body) ->
      json = JSON.parse body
      words = ''

      if json
        words = messageGen json
        if toMe
          noneCount = 0
      else if toMe
        if noneCount > 0
          words = getPhrase 'nonenone'
        else
          words = getPhrase 'none'
        noneCount++

      if words
        msg.reply "> #{url}\n#{words}"
