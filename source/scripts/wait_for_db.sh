#!/bin/bash

for I in {1..30}; do
  if ( echo "" | telnet $PAPERBOY_MYSQL_HOST $PAPERBOY_MYSQL_PORT | grep Escape ); then
    echo done;
    exit 0;
  fi
  sleep 1;
done

exit 1;
