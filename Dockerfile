FROM node:8-alpine
MAINTAINER David Bayer

# Environment variables
ENV HUBOT_SLACK_TOKEN nope-1234-5678-91011-00e4dd
ENV HUBOT_NAME hubot-fred
ENV HUBOT_OWNER none
ENV HUBOT_DESCRIPTION Hubot

RUN adduser -S hubot

RUN npm install -g hubot coffee-script yo generator-hubot

USER hubot

WORKDIR /home/hubot

RUN yo hubot --owner="${HUBOT_OWNER}" --name="${HUBOT_NAME}" --description="${HUBOT_DESCRIPTION}" --defaults && sed -i /heroku/d ./external-scripts.json && sed -i /redis-brain/d ./external-scripts.json && npm install hubot-scripts && npm install hubot-slack --save

VOLUME ["/home/hubot/scripts"]

CMD npm install && \
	bin/hubot -n $HUBOT_NAME --adapter slack
