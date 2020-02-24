FROM ruby:2.7.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y nodejs postgresql-client vim && \
  apt-get install -y yarn

RUN gem install bundler
WORKDIR url-shortener
COPY . .

ADD Gemfile* /
RUN bundle update --bundler

RUN bundle install
RUN bundle exec rails webpacker:install
