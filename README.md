# URL Shortener

An URL Shortener made with Ruby on Rails. It provides a single-field form where
a user can enter an URL and receive a shortened version back. When using this
link, user is redirected to the original website.

## Instalation
Clone the repo:
```
git clone git@github.com:lidimayra/url-shortener.git && cd url-shortener
```

This project is built using Docker. To build and run it:
```
docker-compose build
docker-compose up -d
docker-compose run web bundle exec rake db:schema:load
```

Application will be available on http://localhost:3000/

## Tests

Run the test suite with:
```
docker-compose run web bundle exec rspec
```
