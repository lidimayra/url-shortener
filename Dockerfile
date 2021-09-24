FROM ruby:2.7.1


# Use node v14
RUN apt-get update \
  && apt-get install -y apt-transport-https curl \
  && curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
  && echo "deb https://deb.nodesource.com/node_14.x focal main" \
    > /etc/apt/sources.list.d/nodesource.list

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y nodejs postgresql-client vim && \
  apt-get install -y yarn

# Install Chrome for Selenium
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
RUN dpkg -i /chrome.deb || apt-get install -yf
RUN rm /chrome.deb

# Install chromedriver for Selenium
RUN curl https://chromedriver.storage.googleapis.com/81.0.4044.20/chromedriver_linux64.zip -o /usr/local/bin/chromedriver
RUN chmod +x /usr/local/bin/chromedriver

# start Xvfb using entrypoint (required for running headless tests on ci)
RUN apt-get install -y xvfb
ENV DISPLAY :99
RUN printf '#!/bin/sh\nXvfb :99 -screen 0 1280x1024x24 &\nexec "$@"\n' > /tmp/entrypoint && \
  chmod +x /tmp/entrypoint && \
  mv /tmp/entrypoint /docker-entrypoint.sh

# Suppress Ruby 2.7 warnings
ENV RUBYOPT='-W:no-deprecated -W:no-experimental'

RUN gem install bundler
WORKDIR url-shortener

ADD Gemfile* /
RUN bundle update --bundler

RUN bundle install
RUN yarn install --check-files

RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:install:react
RUN bundle exec rails generate react:install
RUN bundle exec rails webpacker:install:erb

COPY . .
