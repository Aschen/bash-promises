# Bash Promises

Run parallel tasks in bash scripts and wait for resolution.

Example:

```bash
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
```

Roughly equivalent to ("pseudo JS"):

```js
await new Promise((resolve, reject) => {
  echo 1
  sleep 1

  resolve("success")
});

await Promise.all([
  new Promise((resolve, reject) => {
    echo 2
    sleep 1

    resolve("success")
  }),
  new Promise((resolve, reject) => {
    echo 2
    sleep 1
    test -f foobar

    reject("fail")
  })
])

```