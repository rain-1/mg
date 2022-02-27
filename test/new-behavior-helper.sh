#!/bin/bash

source ./expect.sh

# Start up a tmux session
tmux kill-session -t foo 2> /dev/null
tmux -u new-session -d -x 80 -y 24 -s foo

# Launch mg
tmux send -t foo "../mg /tmp/no-newline-testfile.txt" ENTER

# Type some text into mg
tmux send -t foo abc

# Try to exit
tmux send -t foo C-x C-c
tmux capture-pane -p > /tmp/tmux-capture.txt

# check for something like: Save file /tmp/no-newline-testfile.txt? (y or n)
expect /tmp/tmux-capture.txt 'Save file [^?]*\? \(y or n\)' ${LINENO}

tmux send -t foo y

# Check that mg has exited
parent_pid=$(tmux list-panes -s -F '#{pane_pid}' -t foo)
# pstree $parent_pid
ps --ppid ${parent_pid} | grep -q mg
if [ $? -eq 0 ]
then
    echo not ok ${test_name}
    exit 1
fi

tmux kill-session -t foo

