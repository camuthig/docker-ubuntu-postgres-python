FROM ubuntu:16.04

RUN apt-get update -qy && apt-get install -y wget
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -qy && \
  apt-get install -y python3.5 python3.5-dev python3-pip python-dev python3-dev postgresql-9.6 \
    postgresql-server-dev-9.6 sudo && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i '1s/^/local all all peer/' /etc/postgresql/9.6/main/pg_hba.conf

# unit test DB optimizations
RUN echo 'fsync = off' >> /etc/postgresql/9.6/main/postgresql.conf && \
  echo 'full_page_writes = off' >> /etc/postgresql/9.6/main/postgresql.conf
