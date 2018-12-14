FROM ruby:2.5-alpine

COPY . .

RUN bundle install

CMD ["./bot.rb"]
