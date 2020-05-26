#!/bin/sh

promises=0

run_promise () {
  local promise=$1
  local then=$2
  local lockfile=/tmp/promise_$promises

  test -f $lockfile && rm $lockfile

  $($promise) && touch $lockfile && $("$then") &

  promises=$((promises+1))
}

wait_promises () {
  local resolved=0

  until [ $resolved -eq 2 ]
  do
    resolved=0

    i=0
    while [ $i -ne $promises ]
    do
      test -f /tmp/promise_$i && resolved=$((resolved+1))
      i=$((i+1))
    done

    sleep 0.1
  done
}
