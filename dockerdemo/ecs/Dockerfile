FROM ruby:2.7.1

WORKDIR /appdemo
COPY src/ .
RUN bundle install

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "3000"]