FROM elixir:1.9.1

RUN apt-get update && \
apt-get -y install sudo

ADD . /app

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y inotify-tools build-essential postgresql-client

RUN  mix local.rebar --force && \
    mix local.hex --force

WORKDIR /app

EXPOSE 4000

CMD ["./docker-entrypoint.sh"]