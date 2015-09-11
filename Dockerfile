FROM ruby:2.2.3-onbuild
RUN apt-get update && apt-get install -y supervisor redis-server
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV REDIS_URL redis://127.0.0.1:6379
ENV NICKSERV_PASS 

CMD ["/usr/bin/supervisord"]
