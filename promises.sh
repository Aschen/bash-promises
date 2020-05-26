#!/bin/sh

init_promises () {
  promises=0
  rm -rf /tmp/promise_*
}

run_promise () {
  local command=$1
  local then=$2
  local catch=$3

  local identifier=$promises
  local lockfile=/tmp/promise_$identifier

  test -f $lockfile && rm $lockfile

  eval $command \
    && [[ $? -eq 0 ]] \
      && eval $then \
      || eval $catch \
    && touch $lockfile || touch $lockfile &

  promises=$((promises+1))

  return $identifier
}

await_promises () {
  local resolved=0

  until [ $resolved -eq $promises ]
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

await_promise () {
  local lockfile=/tmp/promise_$?
  local resolved=0

  until [ $resolved -eq 1 ]
  do
    resolved=0

    test -f $lockfile && resolved=1

    sleep 0.1
  done
}
