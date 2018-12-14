FROM ruby:2.5-alpine

COPY . .

RUN apk add build-dependencies

RUN bundle install

CMD ["./bot.rb"]
