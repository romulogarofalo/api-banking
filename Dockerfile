FROM elixir:1.6

ENV HOME=/usr/src/api_banking
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y inotify-tools build-essential postgresql-client && \
    apt-get install -y erlang-parsetools && \
    mix local.rebar --force && \
    mix local.hex --force

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

ADD . $HOME
WORKDIR $HOME
EXPOSE 4000