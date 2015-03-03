#!/bin/bash -ex
mkdir -p logs
touch logs/praxis-fog-gateway.log
bundle exec rackup -p 8888
