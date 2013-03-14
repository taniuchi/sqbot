module.exports = (robot) ->

  noneCount = 0
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

  robot.respond /(https?:\/\/[-_.,0-9A-z*&#?=:/]+)/i, (msg) ->
    url = msg.match[1]
    request = msg.http("http://b.hatena.ne.jp/entry/json/#{url}").get()

    request (err, res, body) ->
      json = JSON.parse body

      if not json
        noneCount++
        if noneCount > 1
          words = getPhrase 'nonenone'
        else
          words = getPhrase 'none'
      else
        noneCount = 0
        phs = getPhrase 'exist'
        main = "#{json.title}\n#{json.count}はてﾌﾞ"
        urls = ("[#{e.count}] #{e.title}\n#{e.url}\n" for e in json.related)
        words = "#{phs}\n\n#{main}\n\n#{urls.join('\n')}"

      msg.reply "> #{url}\n#{words}"
