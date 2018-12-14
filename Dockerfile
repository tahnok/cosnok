FROM ruby:2.5-alpine

WORKDIR /cosnok

COPY . .

RUN apk --update add build-base ruby-dev libxml2-dev libxslt-dev

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install

CMD ["/usr/local/bin/bundle", "exec", "ruby", "./bot.rb"]
