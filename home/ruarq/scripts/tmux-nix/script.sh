#!/usr/bin/env bash

SESSION="nix-config"
WORKDIR="$HOME/nix"
WEDITOR="editor"
WCMDS="cmds"

if ! tmux has-session -t $SESSION 2>/dev/null
then
  tmux new-session -d -s $SESSION -c $WORKDIR

  # editor window setup
  tmux rename-window $WEDITOR
  tmux send-keys -t $WEDITOR nvim C-m

  # command window setup
  tmux new-window -c $WORKDIR
  tmux rename-window $WCMDS

  tmux select-window -t $WEDITOR
fi

tmux attach-session -t $SESSION
