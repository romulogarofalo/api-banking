FROM elixir:1.9.1

RUN apt-get update && \
apt-get -y install sudo

ADD . /app

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y inotify-tools build-essential postgresql-client

RUN  mix local.rebar --force && \
    mix local.hex --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

WORKDIR /app

RUN cd ../

RUN mix deps.compile --include-children

RUN mix compile

EXPOSE 4000

CMD ["./docker-entrypoint.sh"]