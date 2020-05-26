#!/bin/bash

source promises.sh

# Init the library
init_promises

# Run a promise: run_promise <command> <then> <catch>
run_promise "echo start 1 && sleep 1" "echo success" "echo fail"

# await the last promise, equivalent to: await promise
await_promise

run_promise "echo 2 && sleep 1" "echo success" "echo fail"
run_promise "echo 3 && sleep 1 && test -f foobar" "echo success" "echo fail"

# await all promises, equivalent to: Promise.all([...])
await_promises
