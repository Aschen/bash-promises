# Bash promise

Today servers have more and more processors but bash scripts remain completely synchronous for the most part.

This library aims to bring asynchronous management routines to your bash scripts to take full advantage of the power of your servers.

Bash promise is a micro bash library composed of 6 functions allowing to execute tasks in parallel in a bash script using promises.

```bash
#!/bin/bash

source promises.sh

# Init the library
init_promises

# Run a promise: promise_run <...command>
promise_run echo "start A"
  promise_then echo "Success A"
  promise_catch echo "Failure A"

```

[See more examples](./example.sh)

## API

### init_promises

Initialize the promise library.  
This function should be called before using the library.

It can be called with `"strict"` to terminate the script if any promise fail.  
This behavior is similar to `set -e`.

```bash
#!/bin/sh

init_promises

# equivalent to set -e
init_promises "strict"
```

### promise_run

Run a command in parallel and returns a promise ID.  

The command is gathered with the `$@` special variable.  

You have to wait the promise fulfillement with either `await_promise` or `await_promises`. Otherwise the script will exit before the command execution is over.

```bash
#!/bin/sh

promise_run tar cfj /lib.tar.xz /lib

```

### promise_then

Execute a command when the promise is resolved and returns the promise ID.  
A promise is marked as resolved when the promise command returns a 0 exit code.


This method should be chain after a call to `promise_run` or `promise_catch`.

The command is gathered with the `$@` special variable.  

```bash
#!/bin/sh

promise_run tar cfj lib.tar.xz /lib
  promise_then scp lib.tar.xz aschen.ovh:lib.tar.xz
```

### promise_catch

Execute a command when the promise is rejected and returns the promise ID.  
A promise is marked as rejected when the promise command returns a non zero exit code.


This method should be chain after a call to `promise_run` or `promise_then`.

The command is gathered with the `$@` special variable.  

```bash
#!/bin/sh

promise_run tar cfj lib.tar.xz /lib
  promise_catch curl aschen.ovh/webhook?backup_fail
```

### await_promises

Wait for every promise fulfillment.  

```bash
#!/bin/sh

promise_run tar xf lib.tar.xz /lib
promise_run tar xf var.tar.xz /var
promise_run tar xf usr.tar.xz /usr

await_promises
```

### await_promise

Wait for a promise fulfillment.  
This method should be called after a call to `promise_run`, `promise_then` or `promise_catch`.

```bash
#!/bin/sh

promise_run tar xf lib.tar.xz /lib
await_promise
```
