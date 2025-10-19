FROM ruby:3.4.7

RUN apt-get update && apt-get install -y build-essential nodejs && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install

COPY . .

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "app.rb"]
