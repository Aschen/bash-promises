#!/bin/bash

source promises.sh

run_promise "sleep 2" "echo Task 1 done"
run_promise "sleep 3" "echo Task 2 done"

wait_promises