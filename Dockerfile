#FROM ruby:rc-alpine
FROM ruby

# Generate lock file first
#docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby bundle install

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install 

COPY . .
RUN gem build statelint.gemspec && gem install statelint-0.4.1.gem

ENTRYPOINT [ "statelint" ]
