#!/usr/bin/env bash

SESSION="nix-config"
WORKDIR="$HOME/nix"
WEDITOR="editor"
WCMDS="cmds"
WREBUILD="rebuild"

if ! tmux has-session -t $SESSION 2>/dev/null
then
  tmux new-session -d -s $SESSION -c $WORKDIR

  # editor window setup
  tmux rename-window $WEDITOR
  tmux send-keys -t $WEDITOR nvim C-m

  # command window setup
  tmux new-window -c $WORKDIR
  tmux rename-window $WCMDS

  # building window setup
  tmux new-window -c $WORKDIR
  tmux rename-window $WREBUILD
  tmux send-keys -t $WREBUILD "cd ./hosts/thinix" C-m
  tmux send-keys -t $WREBUILD "clear" C-m

  tmux select-window -t $WEDITOR
fi

tmux attach-session -t $SESSION
