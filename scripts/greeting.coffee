# Description:
#   特定の文字に反応して人なつっこくあいさつを返します
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <words> - 本文に特定の<words>が含まれていたら用意されたあいさつをランダムに返す
#
# Author:
#   moqada
module.exports = (robot) ->

  greets = [
    'ﾁｨｰｰｰｰｰｰｯｽ!!!',
    'ﾁｮﾘｰｰｰｰｰｰｯｽ!!!',
    'ﾁｮﾘｯｽ!!!',
    'ﾁｯｽ!!!',
    'ﾁｽ!!!',
    'ﾊｰｰｲ!',
    'ｻｾﾝ…ｱｱ…ｴｯﾄ…ﾁﾜｯｽ…',
    'ｱｱ…ｴｯﾄ…ｵﾅｼｬｽ…',
    '(☝ ՞ਊ ՞)☝',
    '(◞≼●≽◟◞౪◟◞≼●≽◟)',
    'ぼ、僕は悪いbotじゃないよ！'
  ]

  robot.respond /(こと.+です[！!。])|(よろしくお(ねが|願)いします)|((こんに?)?ちわ(っす)?)/i, (msg) ->
    idx = parseInt Math.random() * greets.length, 10
    msg.reply "#{greets[idx]}"

  robot.hear /(こと.+です[！!。])|(よろしくお(ねが|願)いします)|((こんに?)?ちわ(っす)?)/i, (msg) ->
    idx = parseInt Math.random() * greets.length, 10
    msg.reply "#{greets[idx]}"
