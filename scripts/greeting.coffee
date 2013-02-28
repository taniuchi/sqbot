module.exports = (robot) ->
  robot.hear /ちわ/i, (msg) ->
    robot.reply msg.message.user, 'チィィーーーーース！！！'
