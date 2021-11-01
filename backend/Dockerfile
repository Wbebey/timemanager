FROM elixir:1.12.3

#  Install postgres client for db connection
RUN apt-get update && \ 
    apt-get install -y inotify-tools && \
    apt-get install -y postgresql-client


# Copy backend
RUN mkdir /backend
COPY . /backend
WORKDIR /backend

# Hex installation
RUN mix local.hex --force

RUN mix deps.get
RUN mix local.rebar --force
RUN mix do compile
RUN chmod +x /backend/backendEntrypoint.sh

EXPOSE 4000

ENTRYPOINT ["/backend/backendEntrypoint.sh"]