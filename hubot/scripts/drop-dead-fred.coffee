# Description:
#   Drop Dead Fred
#
# Configuration:
#   HUBOT_GIPHY_API_KEY
#
# Commands:
#   hubot drop dead - Returns an animated gif from Drop Dead Fred.

giphy =
  api_key: process.env.HUBOT_GIPHY_API_KEY
  base_url: 'http://api.giphy.com/v1'

module.exports = (robot) ->
  robot.respond /(drop dead).*/i, (res) ->
    url = "#{giphy.base_url}/gifs/search"
    robot.http(url) 
        .query
            q: "drop dead fred"
            api_key: giphy.api_key
        .get() (err, msg, body) ->
            if err
                res.send "Error: #{err}"
                return
            response = JSON.parse(body)
            if msg.statusCode isnt 200
                robot.logger.debug body
                res.send "Error: #{response.message}"
                return
            images = response.data
            if images.length == 0
                res.send "No images found!"
                return
            image = res.random images
            res.send image.images.original.url

