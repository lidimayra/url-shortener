FROM ruby:2.7.0

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

# Suppress Ruby 2.7 warnings
ENV RUBYOPT='-W:no-deprecated -W:no-experimental'

RUN gem install bundler
WORKDIR url-shortener
COPY . .

ADD Gemfile* /
RUN bundle update --bundler

RUN bundle install
RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:install:react
RUN bundle exec rails generate react:install
RUN bundle exec rails webpacker:install:erb
