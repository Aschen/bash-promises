# Bash Promises

Run parallel tasks in bash scripts and wait for resolution

```bash
#!/bin/bash

source promises.sh

run_promise "sleep 2" "echo Task 1 done"
run_promise "sleep 3" "echo Task 2 done"

await_promises
```
