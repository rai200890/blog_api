FROM elixir:1.9.1-alpine

WORKDIR app

COPY mix.exs .
COPY mix.lock .

RUN apk add --update postgresql-client make tzdata git
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
  && echo "America/Sao_Paulo" > /etc/timezone

ARG MIX_ENV=dev
ENV MIX_ENV=$MIX_ENV

RUN mix do local.hex --force, local.rebar --force

RUN mix do deps.get, deps.clean --unused, compile

CMD ["sh", "-c", "mix phx.server --no-halt"]
