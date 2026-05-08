#!/usr/bin/env bash

DIRS=$(pwd | tr '/' '\n' | tail -3 | tr '\n' '/' | sed 's:/$::')
BRANCH=$(git branch --show-current 2>/dev/null || echo "no-git")

printf "%s [%s]" "$DIRS" "$BRANCH"
