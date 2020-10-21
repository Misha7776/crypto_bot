#!/usr/bin/env bash

# Wait for Redis
until nc -z -v -w30 redis 6379;
do
  echo 'Waiting for Redis...'
  sleep 1;
done
echo 'Redis is up and running'

bundle exec rake telegram:bot:poller
echo 'Started bot poller.'
