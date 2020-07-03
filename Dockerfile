FROM ruby:2.6.5-alpine3.10

LABEL maintainer="hello@better-projects.com"

RUN apk add --no-cache --update \
  tar \
  tzdata \
  alpine-sdk \
  chromium \
  chromium-chromedriver \
  postgresql-dev \
  nodejs \
  yarn \
  openssh-client \
  zlib-dev \
  xvfb \
  wait4ports \
  xorg-server \
  dbus \
  ttf-freefont \
  mesa-dri-swrast \
  udev \
  imagemagick

# Configure the main working directory. This is the base directory used
# in any further RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p /app
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler && gem update bundler && bundle install --jobs 20 --retry 5
