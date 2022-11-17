# Beautifier
Build script to run a series command line actions and only show the output if there is a failure


To run sync jobs:
```
. ./scripts/beautifier.sh
run_action "mix compile --force --warnings-as-errors"
```

you can also run jobs aysnc by putting multiple commands in a run_actions_concurrently block:

```
run_actions_concurrently \
  "MIX_ENV=test mix compile --warnings-as-errors --force" \
  "yarn --cwd assets deploy"
```

You can pass -v or --verbose to the script that sources this to always show the output
You can pass -fc or --force-colour to force the script to output colour codes even if the terminal type is dumb
