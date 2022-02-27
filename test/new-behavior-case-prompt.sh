#!/bin/bash

source ./expect.sh

echo -n 'test' > /tmp/no-newline-testfile.txt

echo 'set-newline-at-eof-mode prompt' > ~/.mg

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
tmux capture-pane -p > /tmp/tmux-capture.txt
# check that it contains "No newline at end of file, add one? (y or n)"
expect /tmp/tmux-capture.txt 'No newline at end of file, add one\? \(y or n\)' ${LINENO}

tmux kill-session -t foo

echo ok ${test_name}
