#!/bin/sh

# Note: these tests clobber your ~/.mg file
# Hope you got backups!

echo 1..3
test_name='1 - prompt' ./new-behavior-case-prompt.sh
test_name='2 - always' ./new-behavior-case-always.sh
test_name='3 - never' ./new-behavior-case-never.sh
