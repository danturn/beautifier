#!/bin/bash

spinner()
{
  while true; do
    log_success "."
    sleep 0.5
  done
}

run_action() {
  action=$1
  log_info "Running \"$action\""
  spinner&
  spinner_pid=$!
  start_time=$(date +%s.%N)
  output=$(eval $action 2>&1)
  result=$?
  end_time=$(date +%s.%N)
  duration=$(echo "$(date +%s.%N) - $start_time" | bc)
  kill $spinner_pid
  wait $spinner_pid 2>/dev/null

  if [[ $result != 0 ]]; then
    log_failure "failed :*(\n"
    echo "$output"
    log_failure "************************************************\n"
    log_failure "*** At least one thing in \"$action\" is broken ***\n"
    log_failure "************************************************\n"
    exit -1
  else
    log_success "ok!"
    [[ $TERM != "dumb" ]] && printf "\e[32m (%.2f seconds)\n\e[39m" $duration || printf "(%.2f seconds)\n" $duration
  fi
}

log_failure() {
  [[ $TERM != "dumb" ]] && printf "\e[31m$1\e[39m" || boring_log "$1"
}

log_success() {
  [[ $TERM != "dumb" ]] && printf "\e[32m$1\e[39m" || boring_log "$1"
}

log_info() {
  [[ $TERM != "dumb" ]] && printf "\e[35m$1\e[39m" || boring_log "$1"
}

log_banner(){
  [[ $TERM != "dumb" ]]&& printf "\e[36m$1\e[39m" || boring_log "$1"
}

boring_log() {
  printf "$1"
}

sudo echo "a prompt for sudo" >/dev/null
sudo apt-get install bc >/dev/null

###examples of run_action
#run_action "mix deps.get"
#run_action "mix compile --force --warnings-as-errors"
#run_action "mix test --trace --color"

#printf "\n"
#log_success "******************************\n"
#log_success "*** All Actions Succeeded! ***\n"
#log_success "******************************\n"
