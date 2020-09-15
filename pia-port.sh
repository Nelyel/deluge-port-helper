#!/bin/bash

trap 'exit 0' SIGTERM

OLDPORT=0
PORT=0

while true
do
  [ -r "/pia-shared/port.dat" ] && PORT=$(cat /pia-shared/port.dat)

  if [ $OLDPORT -ne $PORT ]; then
    echo "Setting Deluge port settings ($PORT)..."
    deluge-console --config=/deluge/conf "config --set listen_ports ($PORT,$PORT)"
    OLDPORT=$PORT
  fi
  sleep 30 &
  wait $!
done