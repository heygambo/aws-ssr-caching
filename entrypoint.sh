#!/bin/sh
echo "Starting on port $PORT"
DOTENV=$ENVIRONMENT yarn start -H 0.0.0.0 -p $PORT
