FROM elixir:1.12.3

ENV ROOT_DIR=/app

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR $ROOT_DIR

EXPOSE 4000