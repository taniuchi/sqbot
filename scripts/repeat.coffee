module.exports = (robot) ->
  robot.hear /^repeat (.*)/i, (msg) ->
    robot.reply msg.message.user, msg.match[1]
