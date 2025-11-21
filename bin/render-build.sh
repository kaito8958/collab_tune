#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails importmap:json
bundle exec rails assets:precompile
bundle exec rails db:migrate