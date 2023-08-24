FROM ruby:3

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
