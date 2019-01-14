#!/bin/bash

TAG=$(grep -e 'mumuki/mumuki-scratch-worker:[0-9]*\.[0-9]*' ./lib/scratch_runner.rb -o | tail -n 1)

echo "Pulling $TAG..."
docker pull $TAG
