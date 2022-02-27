#!/bin/bash

echo -n 'test' > /tmp/no-newline-testfile.txt
echo 'set-newline-at-eof-mode never' > ~/.mg

source ./expect.sh
source new-behavior-helper.sh

# ensure the output file does not have a newline
str=$(echo -n 'abctest')
if [[ $(< /tmp/no-newline-testfile.txt) != "$str" ]]; then
    echo not ok ${test_name}
    exit 1
fi

echo ok ${test_name}
