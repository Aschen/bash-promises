#!/bin/sh

source promises.sh

# Init the library
init_promises

# Run a promise: promise_run <...command>
promise_run "echo start A && sleep 1"
  promise_then echo "Success A"
  promise_catch echo "Failure A"

# await the last promise, equivalent to: await promise
await_promise

promise_run "echo B && sleep 1"
  promise_then echo "Success B"
  promise_catch echo "Failure B"

promise_run "echo C && sleep 1 && test -f foobar"
  promise_then echo "Success C"
  promise_catch echo "Failure C"

# await all promises, equivalent to: Promise.all([...])
await_promises
