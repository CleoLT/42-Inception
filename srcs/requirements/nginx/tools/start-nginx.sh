#!/bin/bash

echo "nginx entrypoint"
set -x

exec nginx -g "daemon off;"
