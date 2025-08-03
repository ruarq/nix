#!/usr/bin/env bash

SESSION="proofbuddy"
WORKDIR="$HOME/programming/ProveIT/ProofBuddy"
WEDITOR="editor"
WCMDS="cmds"
WWATCH="watch"

if ! tmux has-session -t $SESSION 2>/dev/null; then
  tmux new-session -d -s $SESSION -c $WORKDIR

  # editor setup
  tmux rename-window $WEDITOR
  tmux send-keys -t $WEDITOR nvim C-m

  # build-cmd window setup
  tmux new-window -c $WORKDIR
  tmux rename-window $WCMDS

  # run-dev window setup
  tmux new-window -c $WORKDIR
  tmux rename-window $WWATCH
  tmux send-keys -t $WWATCH "npm run dev" C-m

  tmux select-window -t $WEDITOR
fi

tmux attach-session -t $SESSION
