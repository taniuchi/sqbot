module.exports = (robot) ->

  greets = [
    'ﾁｨｰｰｰｰｰｰｯｽ!!!',
    'ﾁｮﾘｰｰｰｰｰｰｯｽ!!!',
    'ﾁｮﾘｯｽ!!!',
    'ﾁｯｽ!!!',
    'ﾁｽ!!!',
    'ﾊｰｰｲ!',
    '(☝ ՞ਊ ՞)☝',
    '(◞≼●≽◟◞౪◟◞≼●≽◟)',
  ]

  robot.hear /(こんに?)?ちわ(っす)?/i, (msg) ->
    idx = parseInt Math.random() * greets.length, 10
    robot.reply msg.message.user, "@#{msg.message.user.name[0]} #{greets[idx]}"
