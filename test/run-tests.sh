#!/bin/bash

# from https://gist.github.com/intel352/9761288#gistcomment-1774649
vbc_col=$(( $(git show-branch | grep '^[^\[]*\*' | head -1 | cut -d* -f1 | wc -c) - 1 ))
swimming_lane_start_row=$(( $(git show-branch | grep -n "^[\-]*$" | cut -d: -f1) + 1 ))

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
PARENT_BRANCH=`git show-branch | tail -n +$swimming_lane_start_row | grep -v "^[^\[]*\[$CURRENT_BRANCH" | grep "^.\{$vbc_col\}[^ ]" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'`
if [ "" == "$PARENT_BRANCH" ]; then PARENT_BRANCH=master; fi

echo "
parent branch: $PARENT_BRANCH
current branch: $CURRENT_BRANCH
"

echo `git diff --name-only $PARENT_BRANCH $(git merge-base $CURRENT_BRANCH $PARENT_BRANCH)`

