ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster as wrapbook-core

ARG PG_MAJOR
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  curl \
  less \
  git \
  software-properties-common \
  apt-utils \
  shared-mime-info \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add PostgreSQL to sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

# Add NodeJS to sources list
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Add Google Chrome repo
RUN curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list

# Add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu bionic main restricted universe multiverse"

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  libpq-dev \
  postgresql-client-$PG_MAJOR \
  nodejs \
  yarn=$YARN_VERSION-1 \
  vim \
  libcurl4-openssl-dev \
  libffi-dev \
  libreadline-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  zlib1g-dev \
  imagemagick-common \
  libpq-dev \
  libgmp3-dev \
  libexif-dev \
  libfaac-dev \
  pkg-config \
  libexpat1-dev \
  libglib2.0-dev \
  libmagick-dev \
  liborc-0.4-0 \
  liborc-0.4-dev \
  google-chrome-stable \
  autoconf \
  libtool \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

RUN sed -Ei "s/^# deb-src /deb-src /" /etc/apt/sources.list
RUN apt-get update && apt-get build-dep -y imagemagick

RUN mkdir -p /usr/src/libde265
RUN mkdir -p /usr/src/libheif
RUN mkdir -p /usr/src/imagemagick

# Update glib headers
RUN cp /usr/lib/x86_64-linux-gnu/glib-2.0/include/glibconfig.h /usr/include; ldconfig

ENV LANG=C.UTF-8 \
  GEM_HOME=/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH $BUNDLE_BIN:$PATH

# Upgrade RubyGems and install required Bundler version
# See https://github.com/evilmartians/terraforming-rails/pull/24 for discussion
ENV BUNDLER_VERSION=$BUNDLER_VERSION
RUN gem update --system && \
  gem install bundler -v $BUNDLER_VERSION

RUN mkdir -p /app
WORKDIR /app
