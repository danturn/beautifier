# Beautifier
Build script to run a series command line actions and only show the output if there is a failure

e.g.

```
. ./scripts/beautifier.sh
run_action "mix compile --force --warnings-as-errors"
```

You can pass -v or --verbose to the script that sources this to always show the output
