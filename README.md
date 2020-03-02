[![lidimayra](https://circleci.com/gh/lidimayra/url-shortener/tree/master.svg?style=svg)](https://circleci.com/gh/lidimayra/url-shortener/tree/master) [![codecov.io](http://codecov.io/github/lidimayra/url-shortener/coverage.svg?branch=master)](http://codecov.io/github/lidimayra/url-shortener?branch=master)

# URL Shortener

An URL Shortener made with Ruby on Rails and ReactJS. It provides a single-field
form where a user can enter an URL and receive a shortened version back. When
using this link, user is redirected to the original website.

Once a valid URL is submitted, it is recorded to the database, so it can be
used for unlimited period. Each URL is unique, therefore, once an URL is
shortened, any attempt to short the same URL again, will result in the same
shortened link.

The app is available in three languages: English :us:, Portuguese :brazil: and
German :de:.

## Instalation
Clone the repo:
```
git clone git@github.com:lidimayra/url-shortener.git && cd url-shortener
```

This project is built using Docker. To build and run it:
```
docker-compose build
docker-compose up -d
docker-compose run web bundle exec rake db:setup
```

Application will be available on http://localhost:3000/

## Tests

Tests are built using RSpec/Capybara. Run the test suite with:
```
docker-compose run web bundle exec rspec
```

## URL Shortener endpoint
It is possible to use the URL shortener through an endpoint as well. In order to
do that, a _POST_ request to `/urls` is required. It expects to receive a
request body parameter containing an URL object.

e.g.:
```json
{
    "url": {
        "id": 5,
        "original": "https://www.google.com/search?q=lorem+ipsum",
        "shortened": "2c1a1ed",
        "created_at": "2020-03-02T04:13:03.050Z",
        "updated_at": "2020-03-02T04:13:03.050Z"
    },
    "errors": {}
}
```

Would return something like:
```json
{
    "url": {
        "id": 5,
        "original": "https://www.google.com/search?q=lorem+ipsum",
        "shortened": "2c1a1ed",
        "created_at": "2020-03-02T04:13:03.050Z",
        "updated_at": "2020-03-02T04:13:03.050Z"
    },
    "errors": {}
}
```

`url.shortened` corresponds to path. Therefore, if the request is performed
from http://localhost:3000, it means that the shortened link in this scenario
would be http://localhost:3000/2c1a1ed.
