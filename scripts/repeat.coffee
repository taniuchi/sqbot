module.exports = (robot) ->
  robot.hear /.*/i, (msg) ->
    robot.reply msg.message.user, msg.message.text
